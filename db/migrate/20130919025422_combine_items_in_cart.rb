class CombineItemsInCart < ActiveRecord::Migration
  def up
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(product_id: product_id).delete_all
          # replace with a single line
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    LineItem.where('quantity > 1').each do |line_item|
      # Add individual line items
      line_item.quantity.times do
        LineItem.create(cart_id: line_item.cart.id,
                        product_id: line_item.product.id,
                        quantity: 1)
      end
      # remove the original
      line_item.destroy
    end
  end
end
