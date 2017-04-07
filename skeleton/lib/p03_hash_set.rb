require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    resize! if @count > num_buckets
    self[key] << key
  end

  def include?(key)
    self[key].any? {|n| n == key}
  end

  def remove(key)
    self[key].reject! {|n| n == key}
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_elements = @store.flatten
    new_arr = HashSet.new(num_buckets)
    old_elements.each do |el|
      new_arr.insert(el)
    end
    @store = new_arr.store
  end
end
