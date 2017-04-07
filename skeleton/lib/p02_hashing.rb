class Fixnum
  # Fixnum#hash already implemented for you
end

class Symbol

end

class Array
  def hash
    self.join("").to_i.hash
  end
end

class String
  def hash
    self.chars.map { |ch| ch.ord }.join("").to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash

    garbage_sum = 0

    self.to_a.flatten.each do |el|
      if el.is_a? Symbol
        garbage_sum += el.to_s.hash
      elsif el.is_a? Integer 
        garbage_sum += (el + 97).chr.hash
      else
        garbage_sum += el.hash
      end
    end

    garbage_sum
  end
end


# storage = Array.new(5) { [] }
#
# self.each do |key, val|
#   storage[key.hash % storage.count] << [key, val]
# end
#
# storage
