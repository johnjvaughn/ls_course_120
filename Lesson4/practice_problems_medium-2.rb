class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end

puts <<-QA

Q. Alan looked at the code and spotted a mistake. 
   "This will fail when update_quantity is called", he says.
   Can you spot the mistake and how to address it?

A. "@quantity" is an instance var but has no setter method set
   So the update_quantity method is just setting a local var called
   "quantity", not changing the value of @quantity.

QA

entry = InvoiceEntry.new('a product', 3)
entry.update_quantity(5)
p entry.quantity
