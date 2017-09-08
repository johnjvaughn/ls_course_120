class CircularQueue
    def initialize(length)
    @queue = Array.new(length)
    @add_index = 0
    @ref_queue = []
  end

  def enqueue(item)
    @add_index = @ref_queue.shift if queue_full?
    @queue[@add_index] = item
    @ref_queue.push(@add_index)
    increment_add_index
  end

  def dequeue
    return nil if queue_empty?
    oldest_index = @ref_queue.shift
    @add_index = oldest_index unless @queue[@add_index] == nil
    item = @queue[oldest_index]
    @queue[oldest_index] = nil
    item
  end

  def to_s
    "queue: #{@queue}, ref_queue: #{@ref_queue}, add_index: #{@add_index}"
  end

  private

  def queue_empty?
    @queue.all? { |item| item == nil }
  end

  def queue_full?
    @queue.all? { |item| item != nil }
  end

  def increment_add_index
    @add_index = (@add_index + 1) % @queue.size
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil