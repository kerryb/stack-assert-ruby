class Stack
  def initialize
    @empty = true
  end

  def push item
    @empty = false
  end

  def empty?
  end
end

def assert_equal expected, actual, message
  expected == actual or $stderr.puts message
end

assert_equal true, Stack.new.empty?, "A new stack should be empty"

stack = Stack.new
stack.push :foo
assert_equal false, stack.empty?, "A stack that's been pushed to should not be empty"
