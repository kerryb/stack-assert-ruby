class Stack
  class EmptyStackError < RuntimeError; end

  def initialize
    @empty = true
  end

  def push item
    @empty = false
    @item = item
  end

  def pop
    raise EmptyStackError if @item.nil?
    item = @item
    @item = nil
    item
  end

  def empty?
    @empty
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
