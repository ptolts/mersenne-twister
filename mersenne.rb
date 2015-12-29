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

number = 100
least_significant_bits = 6

puts number.to_binary

puts 'mask: ', number.generate_mask(least_significant_bits).to_binary

puts 'result: ', number.least_significant(least_significant_bits).to_binary
