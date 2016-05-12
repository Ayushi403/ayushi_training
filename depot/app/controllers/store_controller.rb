class StoreController < ApplicationController
	def index
			#@products = Product.order(:title)
			#@categories = Category.get_all_category
			@categories = Category.all
			@cart = current_cart 
  end

end


