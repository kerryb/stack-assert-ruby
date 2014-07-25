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

def assert_equal expected, actual, message
	actual == expected or fail "#{message} (expected #{expected.inspect}, got #{actual.inspect})"
end

def assert_true actual, message
	assert_equal true, actual, message
end

def assert_false actual, message
	assert_equal false, actual, message
end

assert_true Stack.new.empty?, "A new stack should be empty"

stack = Stack.new
stack.push 1
assert_false stack.empty?, "A stack should not be empty after pushing"

stack = Stack.new
stack.push "I am an item."
assert_equal "I am an item.", stack.pop, "Popping an item from the stack should return the last item added."

stack = Stack.new
stack.push "Item"
stack.pop
assert_true stack.empty?, "Stack should be empty after popping the last item."

stack = Stack.new
stack.push 1
stack.push 2
assert_equal [2,1], [stack.pop, stack.pop], "Stack should pop items in the reverse order that they were pushed."

stack = Stack.new
stack.push 1, 2
stack.pop
assert_false stack.empty?, "A stack should not be empty if there are still items remaining"

stack = Stack.new
begin
	stack.pop
	fail "An empty stack should throw an exception"
rescue StackEmptyException
end

stack = Stack.new
stack.push 1, 2
assert_equal [2,1], [stack.pop, stack.pop], "Push should accept multiple items."
