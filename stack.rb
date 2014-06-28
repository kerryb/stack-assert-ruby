class Stack
  def empty?
    true
  end
end

Stack.new.empty? or $stderr.puts "A new stack should be empty"

stack = Stack.new
stack.push :foo
!stack.empty? or $stderr.puts "A stack that's been pushed to should not be empty"
