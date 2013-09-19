module StoreHelper
  def cart_item_count(cart)
    #  pluralize(1, 'item') # => "1 item"
    #  pluralize(25, 'item') # => "25 items"
    "#{pluralize(cart.total_quantity, 'item')}"
  end
end
