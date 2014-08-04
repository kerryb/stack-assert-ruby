class ExpectationFailed < RuntimeError

end

class Double
  Call = Struct.new(:method, :args)

  def initialize
    @calls = []
  end

  def method_missing method, *args
    @calls << Call.new(method, args)
  end

  def should_have_received method, args= []
    call = Call.new(method, args)
    unless @calls.include? call
      fail ExpectationFailed.new "Method: #{method} not called with #{args.inspect}"
    end
  end
end

def assert_equal expected, actual
  if expected != actual
    fail ExpectationFailed.new("Expected: #{expected}, got: #{actual}")
  end
end

def assert_true actual
  assert_equal(true, actual)
end

def assert_false actual
  assert_equal(false, actual)
end

def assert_exception exception_class, &test_code
  begin
    yield test_code
    fail
  rescue exception_class
  end
end

def specify message, &test_case
  begin
    yield test_case
    print "."
  rescue ExpectationFailed => e
    print "F"
    @messages << message
    @messages << e.message
    @messages << e.backtrace
    @messages << "\n"
  end
end

def expound message, &test_cases
  @messages = []

  yield test_cases

  puts
  puts @messages.join "\n"
end

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

  def each &block
    @items.each(&block)
  end
end

expound "some stuff" do

  specify "a new stack is empty" do
    assert_true(Stack.new.empty?)
  end

  specify "a stack with something pushed to it is not empty" do
    stack = Stack.new
    stack.push(1)
    assert_false(stack.empty?)
  end

  specify "popping from a stack with one item returns the last added item" do
    stack = Stack.new
    stack.push(1)
    assert_equal(1, stack.pop)
  end

  specify "popping an empty stack raises the empty stack exception" do
    assert_exception Stack::Empty do
      Stack.new.pop
    end
  end

  specify "a stack is empty after popping the last item" do
    stack = Stack.new
    stack.push(1)
    stack.pop
    assert_true stack.empty?
  end

  specify "items are popped LIFO" do
    stack = Stack.new
    stack.push(1)
    stack.push(2)
    assert_equal([2,1], [stack.pop, stack.pop])
  end

  specify "a method can be called on each item" do
    stack = Stack.new
    item_1 = Double.new
    item_2 = Double.new
    stack.push item_1
    stack.push item_2

    n = 41
    stack.each {|item| item.foo(n += 1) }

    item_1.should_have_received(:foo, [42])
    item_2.should_have_received(:foo, [43])
  end
end
