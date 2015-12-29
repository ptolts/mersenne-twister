require 'chunky_png'

F = 1812433253
W = 32
M = 397
R = 31
A = Integer('0x9908B0DF')
U = 11
D = Integer('0xFFFFFFFF')
S = 7
T = 15
C = Integer('0xEFC60000')
B = Integer('0x9D2C5680')
N = 624
L = 18
LOWER_MASK = (1 << R) - 1
LOWER_W_MASK = ((1 << W) - 1)
UPPER_MASK = (~LOWER_MASK) & LOWER_W_MASK

module ExtendNumber
  def to_binary
    self.to_s(2)
  end

  def least_significant
    self & LOWER_W_MASK
  end
end

class Fixnum
  include ExtendNumber
end

class Bignum
  include ExtendNumber
end

class Mersenne
  attr_accessor :index, :mt
  def initialize(seed)
    @index  = N
    @mt     = Array.new(N, 0)
    @mt[0]  = seed

    (1..(N - 1)).each do |i|
      last_val          = @mt[i-1]
      last_val_shifted  = last_val >> (W - 2)
      xored             = last_val ^ last_val_shifted
      multiplied        = (F * xored) + i
      @mt[i]            = multiplied & LOWER_W_MASK
    end
  end

  def extract_number
    twist if @index == N

    y = @mt[@index]
    y = y ^ ((y >> U) & D)
    y = y ^ ((y << S) & B)
    y = y ^ ((y << T) & C)
    y = y ^ (y >> L)

    @index += 1
    y.least_significant
  end
  alias :random :extract_number

  def twist
    (0..(N - 1)).each do |i|
      x      = (@mt[i] & UPPER_MASK) +
                (@mt[(i+1) % N] & LOWER_MASK)
      xa     = x >> 1
      xa     = xa ^ A if (x % 2) != 0
      @mt[i] = @mt[(i + M) % N] ^ xa
    end
    @index = 0
  end
end

mersenne = Mersenne.new(1)
image_size = 512

png = ChunkyPNG::Image.new(image_size, image_size, ChunkyPNG::Color::WHITE)
(1..image_size - 1).each do |x|
  (1..image_size - 1).each do |y|
    png[x, y] = ChunkyPNG::Color.rgb(0, 0, 0) if (mersenne.random % 2 == 0)
  end
end

png.save('random.png')
