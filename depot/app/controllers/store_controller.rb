class StoreController < ApplicationController
	def index
			#@products = Product.order(:title)
			#@categories = Category.get_all_category
			#@categories = Category.all
			@categories = Category.includes(:sub_categories)

			@products = Product.joins(sub_category: :category)

			if !params[:sub_cat_id].blank?
				#@sub_cat_id = params[:sub_cat_id]
				@products = @products.where('sub_category_id =?' , params[:sub_cat_id])
			elsif !params[:cat_id].blank?
				#binding.pry
				#@cat_id = 3#params[:cat_id]
				@products = @products.where('categories.id =?' , params[:cat_id])
			end

			@cart = current_cart 
		end

	end


