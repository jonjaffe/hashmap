class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" if num < 0 || num > @max
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].reject! {|n| n == num }
  end

  def include?(num)
    self[num].any? {|n| n == num }
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count > @store.length
    self[num] << num
  end

  def remove(num)
    self[num].reject! { |n|  n == num}
  end

  def include?(num)
    self[num].any? {|n| n == num}
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    if @count > @store.length
      @store.length * 2
    else
      @store.length
    end
  end

  def resize!
    old_elements = @store.flatten
    new_arr = ResizingIntSet.new(num_buckets)
    old_elements.each do |el|
      new_arr.insert(el)
    end
    @store = new_arr.store
  end
end
