class Stack
  class EmptyStackError < RuntimeError; end

  def initialize
    @items = []
  end

  def push item
    @items << item
  end

  def pop
    raise EmptyStackError if empty?
    @items.delete_at(-1)
  end

  def empty?
    @items.empty?
  end
end

def fail message
  $stderr.puts "FAILED: #{message}"
end

def assert_equal expected, actual, message
  expected == actual or fail "#{message} (expected #{expected.inspect}, got #{actual.inspect})"
end

assert_equal true, Stack.new.empty?, "A new stack should be empty"

stack = Stack.new
stack.push :foo
assert_equal false, stack.empty?, "A stack that's been pushed to should not be empty"

stack = Stack.new
stack.push :foo
assert_equal :foo, stack.pop, "Popping a stack after pushing an item should return the item"

stack = Stack.new
begin
  stack.pop
  fail "Popping an empty stack should raise a Stack::EmptyStackError"
rescue Stack::EmptyStackError
end

stack = Stack.new
stack.push :foo
stack.pop
assert_equal true, stack.empty?, "A stack should be empty after popping the last item"

stack = Stack.new
stack.push :foo
stack.push :bar
first = stack.pop
second = stack.pop
assert_equal [:bar, :foo], [first, second], "Items should be popped off the stack in LIFO order"
