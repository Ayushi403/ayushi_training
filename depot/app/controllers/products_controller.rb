class ProductsController < ApplicationController
  before_filter :set_admin
  #before_filter :check_permissions

  def set_admin
    @is_admin = true
  end

  def check_permissions
   # authorize!,Product
  end
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    authorize! :index, Product
    @total_orders = Order.count
    #binding.pry
    @total_price    = Order.total_amount
    @pending_amount = Order.pending_amount

    #@cat_list = Category.all
    #@products = Category.subca.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    authorize! :show, Product

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    #@cat_list = Category.all
    @cat_list = Category.includes(:sub_categories).order(:name)
    @product = Product.new
    authorize! :new, Product
   # @Category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    authorize! :create, Product

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
        #format.js
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    authorize! :update, Product

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    authorize! :destroy, Product

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
    end
  end
end
