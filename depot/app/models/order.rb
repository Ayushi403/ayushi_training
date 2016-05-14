class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
	validates :name, :address, :email, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES
	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			line_items << item
		end
	end


	def self.total_amount
		order_done = Order.where(:payment_status =>'done')
		#total = Order.sum('total_price')
		total = order_done.sum(:total_price)
		total
	end

	def self.pending_amount
		order_done = Order.where(:payment_status =>'pending')
		#total = Order.sum('total_price')
		total = order_done.sum(:total_price)
		total
	end
end

