class StoreController < ApplicationController
	before_filter :authenticate_user!
  def index
  	binding.pry
  	@products = Product.order(:title)
  	@cart = current_cart
  end

end
