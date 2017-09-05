class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

puts <<-QA

Q. Does the "balance >= 0" statement need a @ before balance?

A. Yes -- otherwise Ruby thinks this is a local variable. It needs
   to use either @balance or self.balance.
   CORRECTION: No it doesn't need the @ to know this is a reference
   to the getter method, rather than a local var.

QA

acct = BankAccount.new(1000)
puts acct.positive_balance?