class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  OPERATIONS = { 'ADD' => :+, 'SUB' => :-, 'MULT' => :*, 'DIV' => :/, 'MOD' => :% }
  ACTIONS = %w[PUSH POP PRINT]

  def initialize(command)
    @commands = command.split
    @stack = []
    @register = 0
  end

  def eval
    @commands.each do |cmd|
      if OPERATIONS.key?(cmd)
        operation(OPERATIONS[cmd])
      elsif ACTIONS.include?(cmd)
        send(cmd.downcase.to_sym)
      elsif cmd.to_i.to_s == cmd
        @register = cmd.to_i
      else
        raise BadTokenError, "Invalid Token: #{cmd}"
      end
    end
  rescue MinilangRuntimeError => error
    puts error.message
  end

  private

  def push
    @stack << @register
  end

  def pop
    raise EmptyStackError, "Empty Stack!" if @stack.empty?
    @register = @stack.pop
  end

  def print
    puts @register
  end
  
  def operation(op)
    @register = @register.send(op, @stack.pop)
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)