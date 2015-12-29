require 'chunky_png'

MASK = Integer('0xFFFF')
MAX_RAND = 2 ** 32
@state = [2, 8]

def mwc1616
    r0 = (18030 * (@state[0] & MASK)) + (@state[0] >> 16) | 0
    r1 = (36969 * (@state[1] & MASK)) + (@state[1] >> 16) | 0
    @state = [r0, r1]
    x = ((r0 << 16) + (r1 & MASK)) | 0
    x = x + MAX_RAND if x < 0
    return x / MAX_RAND
end

@image_size = 2048

def random(max)
  max = max - 1
  min = 1
  mwc1616 % (max - min + 1) + min
end


png = ChunkyPNG::Image.new(@image_size, @image_size, ChunkyPNG::Color::WHITE)
(1..@image_size - 1).each do |x|
  (1..@image_size - 1).each do |y|
    png[random(@image_size), random(@image_size)] = ChunkyPNG::Color.rgb(0,0,0)
  end
end

png.save('bad_random.png')
