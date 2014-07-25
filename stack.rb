class Stack

  class Empty < RuntimeError; end

  def initialize
    @items = []
  end

  def empty?
    @items.count == 0
  end

  def push item
    @items << item
  end

  def pop
    raise Empty if empty?
    @items.delete_at(-1)
  end
end

def assert_equal expected, actual, message
  if expected != actual
    fail message
  else
    print "."
  end
end

assert_equal(true, Stack.new.empty?, "A new stack is empty")

stack = Stack.new
stack.push(1)
assert_equal(false, stack.empty?, "A stack with something pushed to it is not empty")

stack = Stack.new
stack.push(1)
assert_equal(1, stack.pop, "Popping from a stack with one item returns the last added item")

begin
  Stack.new.pop
  fail "Popping an empty stack raises the empty stack exception"
rescue Stack::Empty
end

stack = Stack.new
stack.push(1)
stack.pop
assert_equal(true, stack.empty?, "A stack is empty after popping the last item")

stack = Stack.new
stack.push(1)
stack.push(2)
assert_equal([2,1], [stack.pop, stack.pop], "Items are popped LIFO")


