class StoreController < ApplicationController
	def index
			#@products = Product.order(:title)
			#@categories = Category.get_all_category
			#@categories = Category.all

			@categories = Category.includes(:sub_categories).order(:name)

			#@products = Product.joins(sub_category: :category)
			@products = Product.get_all_category
			if @products.present?
			@products = JSON.parse(@products)
		end
			#@products = JSON.parse(temp)

			if !params[:sub_cat_id].blank?
				#@sub_cat_id = params[:sub_cat_id]				
				#@products = @products.where('sub_category_id =?' , params[:sub_cat_id].to_i)
				@products = @products.select{|i| i["sub_category_id"] ==params[:sub_cat_id].to_i && i["cat_id"] == params[:cat_id].to_i}

			elsif !params[:cat_id].blank?
				#binding.pry
				#@cat_id = 3#params[:cat_id]
				#@products = @products.where('categories.id =?' , params[:cat_id].to_i)
				@products = @products.select{|i| i["cat_id"] == params[:cat_id].to_i}
			end
			@cart = current_cart 

			respond_to do |format|
      format.html # index.html.erb
      format.js# { render 'index'}
      format.json { render json: @products }
    end
		end

	end


