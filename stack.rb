class Stack
  def empty?
    true
  end
end

Stack.new.empty? or $stderr.puts "A new stack should be empty"
