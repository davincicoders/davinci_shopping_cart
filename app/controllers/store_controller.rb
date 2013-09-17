class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.paginate(page: params[:page], per_page: 10)
  end

  def my_cart
  end
end
