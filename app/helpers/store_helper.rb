module StoreHelper
  def cart_item_count(cart)
    "#{pluralize(cart.line_items.count, 'item')}"
  end
end
