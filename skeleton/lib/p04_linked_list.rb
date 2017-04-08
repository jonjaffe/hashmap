require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @head.prev = nil
    @tail.prev = @head
    @tail.next = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    # debugger
    previous_last = @tail.prev
    new_last = Link.new(key, val)

    @tail.prev = new_last
    new_last.next = @tail
    previous_last.next = new_last
    new_last.prev = previous_last

  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
      end
    end
  end

  def remove(key)

    self.each do |link|
      if link.key == key
        prev_link = link.prev
        next_link = link.next
        prev_link.next = next_link
        next_link.prev = prev_link
      end
    end
  end

  def each
    current_link = first

    while current_link.next != nil
      yield current_link
      current_link = current_link.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
