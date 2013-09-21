class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    line_item = @cart.add_product(product.id)

    respond_to do |format|
      if line_item.save
        format.html { redirect_to root_path, notice: 'Product added to cart' }
        format.js { @current_item = line_item }
      else
        format.html { redirect_to root_path, flash: {error: 'Product could not be added to cart'} }
        format.js
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: {error: 'Unable to find product'}
  end
end
