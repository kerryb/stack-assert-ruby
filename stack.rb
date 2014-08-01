def assert_equal expected, actual
  if expected != actual
    fail
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
  rescue => e
    print "F"
    @messages << message
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
end

expound "some stuff" do

  specify "A new stack is empty" do
    assert_true(Stack.new.empty?)
  end

  specify "A stack with something pushed to it is not empty" do
    stack = Stack.new
    # stack.push(1)
    assert_false(stack.empty?)
  end

  specify "Popping from a stack with one item returns the last added item" do
    stack = Stack.new
    stack.push(1)
    assert_equal(1, stack.pop)
  end

  specify "Popping an empty stack raises the empty stack exception" do
    assert_exception Stack::Empty do
      Stack.new.pop
    end
  end

  specify "A stack is empty after popping the last item" do
    stack = Stack.new
    stack.push(1)
    stack.pop
    assert_true stack.empty?
  end

  specify "Items are popped LIFO" do
    stack = Stack.new
    stack.push(1)
    stack.push(2)
    assert_equal([2,1], [stack.pop, stack.pop])
  end
end
