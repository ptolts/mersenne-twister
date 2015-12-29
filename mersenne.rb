class Fixnum
  def to_binary
    self.to_s(2)
  end

  def least_significant(n)
    self & generate_mask(n)
  end

  def generate_mask(n)
    (0).upto(n - 1).inject(0) do |result, index|
      result += (1 << index)
      result
    end
  end
end

F = 1812433253
W = 32
M = 397
R = 31
A = 2567483615
U = 11
D = 4294967295
S = 7
T = 15
C = 4022730752
B = 2636928640
N = 624
L = 18
UPPER_MASK = (~1.generate_mask(W)).least_significant(W)

class Mersenne
  attr_accessor :index, :mt
  def initialize(seed)
    @index  = N
    @mt     = Array.new(N, 0)
    @mt[0]  = seed

    (1..N).each do |i|
      last_val          = @mt[i-1]
      last_val_shifted  = last_val >> (W - 2)
      xored             = last_val ^ last_val_shifted
      @mt[i]            = (F * xored) + i
    end
  end

  def extract_number
    twist if @index >= N

    y = @mt[@index]
    y = y ^ ((y >> U) & D)
    y = y ^ ((y << S) & B)
    y = y ^ ((y << T) & C)
    y = y ^ (y >> L)

    @index += 1
    y.least_significant(W)
  end

  def twist
    (0..N).each do |i|

    end
  end
end

number = 100
least_significant_bits = 6

puts number.to_binary

puts 'mask: ', number.generate_mask(least_significant_bits).to_binary

puts 'result: ', number.least_significant(least_significant_bits).to_binary
