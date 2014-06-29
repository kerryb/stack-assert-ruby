class Stack
  def initialize
    @empty = true
  end

  def push item
    @item = item
    @empty = false
  end

  def pop
    @item
  end

  def empty?
    @empty
  end
end

def assert_equal expected, actual, message
  expected == actual or $stderr.puts "FAILED: #{message} (expected #{expected.inspect}, got #{actual.inspect})"
end

assert_equal true, Stack.new.empty?, "A new stack should be empty"

stack = Stack.new
stack.push :foo
assert_equal false, stack.empty?, "A stack that's been pushed to should not be empty"

stack = Stack.new
stack.push :foo
assert_equal :foo, stack.pop, "Popping a stack after pushing an item should return the item"
