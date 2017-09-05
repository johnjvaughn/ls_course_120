class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

puts <<-QA

Q. One way to fix this is to change attr_reader to attr_accessor and change quantity to self.quantity.
   Is there anything wrong with fixing it this way?

A. Once an attr_accessor is in place, the variable value can be altered from outside the class.
   That may not be desirable to allow.

QA

