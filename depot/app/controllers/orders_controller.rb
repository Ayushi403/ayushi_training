class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end
    @order = Order.new
    #@order.total_price = (params[:total_price])
    respond_to do |format|
format.html # new.html.erb
format.json { render json: @order }
end
end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
    @order.payment_status = 'pending'
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(current_user.cart.id)
        session[:cart_id] = nil
        #format.html { redirect_to store_url, notice:
                                               #'Thank you for your order.' }
        format.html {redirect_to @order, notice: 'Thank you for your order,click to pay.'}
        format.json { render json: @order, status: :created,
                             location: @order }
      else
        @cart = current_cart
        format.html { render action: "new" }
        format.json { render json: @order.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
    end
  end

  def payment
    @order = Order.find(params[:order_id])
    payment_status = 'done'

    respond_to do |format|
      if @order.update_attributes(:payment_status => payment_status)
        format.html 
      end
    end
  end

end
