class Stack
  def initialize
    @items = []
  end

  def empty?
    @items.size.zero?
  end

  def push *items
    @items += items
  end

  def pop
    raise StackEmptyException if empty?
    @items.delete_at(-1)
  end
end

class StackEmptyException < RuntimeError
end

############ TEST FRAMEWORK ############

@tests = []

Test = Struct.new :description, :block do
  def run
    block.call
    :pass
  rescue TestFailure => e
    $stderr.puts "FAILED: #{description} (#{e.message})"
    :fail
  rescue Exception => e
    $stderr.puts "ERROR: #{description} (#{e.message})"
    :error
  end
end

class TestFailure < RuntimeError
end

def specify description, &block
  @tests << Test.new(description, block)
end

at_exit do
  results = @tests.map(&:run)
  passes = results.count(:pass)
  failures = results.count(:fail)
  errors = results.count(:error)
  puts "#{results.size} tests. #{passes} passed, #{failures} failed, #{errors} error#{'s' unless errors == 1}"
  exit failures + errors
end

def assert_equal expected, actual
  actual == expected or fail TestFailure.new("expected #{expected.inspect}, got #{actual.inspect}")
end

def assert_true actual
  assert_equal true, actual
end

def assert_false actual
  assert_equal false, actual
end

def assert_raises error, &block
  block.call
  fail TestFailure.new("expected #{error}, but nothing was raised")
rescue error
end
############ TESTS ############

specify "A new stack should be empty" do
  assert_true Stack.new.empty?
end

specify "A stack should not be empty after pushing" do
  stack = Stack.new
  stack.push 1
  assert_false stack.empty?
end

specify "Popping an item from the stack should return the last item added" do
  stack = Stack.new
  stack.push 1
  assert_equal 1, stack.pop
end

specify "Stack should be empty after popping the last item" do
  stack = Stack.new
  stack.push 1
  stack.pop
  assert_true stack.empty?
end

specify "Stack should pop items in the reverse order that they were pushed" do
  stack = Stack.new
  stack.push 1
  stack.push 2
  assert_equal [2,1], [stack.pop, stack.pop]
end

specify "A stack should not be empty if there are still items remaining" do
  stack = Stack.new
  stack.push 1, 2
  stack.pop
  assert_false stack.empty?
end

specify "An empty stack should throw an exception" do
  stack = Stack.new
  assert_raises(StackEmptyException) { stack.pop }
end

specify "Push should accept multiple items" do
  stack = Stack.new
  stack.push 1, 2
  assert_equal [2,1], [stack.pop, stack.pop]
end
