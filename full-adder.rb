# This is a representation in ruby of the Ben Eater video: https://www.youtube.com/watch?v=wvJc9CZcvBc&t=606s
# Ruby has binary math built in, but this was to demonstrate binary addition with logic gates

class FullAdder

  def initialize(num0, num1)
    # Reverse them so the 0th column is first
    bins0 = num0.reverse().split("")
    bins1 = num1.reverse().split("")
    
    puts full_adder(bins0, bins1)
  end

  def full_adder(bins0, bins1)
    carry = 0
    sum   = []

    bins0.each_index do |idx|
      # xor the numbers
      xor1 = xor_gate(bins0[idx].to_i, bins1[idx].to_i)

      # and the numbers
      and1 = and_gate(bins0[idx].to_i, bins1[idx].to_i)

      # xor the outcome of xor1, and the carry bit
      sum_el = xor_gate(xor1.to_i, carry.to_i)

      # and the outcome of xor1, and the carry bit
      and2 = and_gate(xor1.to_i, carry.to_i)

      # One final or to update the carry bit
      carry = or_gate(and1.to_i, and2.to_i)

      # Update the sum array
      sum.insert(0, sum_el)
    end

    # Since we're done, tack the left over one on the front
    if carry > 0
      sum.insert(0, carry)
    end

    sum.join("")
  end

  def xor_gate(num0, num1)
    return num0.to_i ^ num1.to_i
  end

  def and_gate(num0, num1)
    return num0.to_i & num1.to_i
  end

  def or_gate(num0, num1)
    return num0.to_i | num1.to_i
  end

end

puts "#{ARGV[0]} plus #{ARGV[1]} equals: "
FullAdder.new(ARGV[0], ARGV[1])
