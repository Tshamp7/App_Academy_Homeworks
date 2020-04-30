#This is an LRU cache implementation using an array. It would be more efficient to implement this using
#a doubly-linked list as this would improve the time of adding items to O(1) time from O(n) time.

class LRUCache
  attr_reader :store, :size
  def initialize(size)
    @store = []
    @size = size
  end

  def add(item)
    if @store.include?(item)
      @store.delete(item)
      @store << item
    elsif @store.length == @size
      @store.shift
      @store << item
    else
      @store << item
    end
  end

  def count
    @store.length
  end

  def show
    p @store
  end
end