class Public::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
  	@order = Order.new
    @cart_items = current_customer.cart_items
    @customer = current_customer
  end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def comfirm
	 @order = Order.new(order_params)
	 @cart_items = current_customer.cart_items

		@sum = 0
		@cart_items.each do |cart_item|
			@sum += cart_item.item.price * cart_item.amount
		end
		@order.shipping_cost = 800
		@order.total_payment = @sum + 800

		destination = params[:a_method].to_i

		if destination == 0

			@order.postal_code = current_customer.postal_code
			@order.address = current_customer.address
			@order.name = current_customer.last_name + current_customer.first_name

		elsif destination == 1
			address = Address.find(params[:address_for_order])
			@order.postal_code = address.postal_code
			@order.address = address.address
			@order.name = address.name

		elsif destination == 2

			@order.postal_code = params[:postal_code]
			@order.address = params[:address]
			@order.name = params[:name]
		end

	end

	def create
    	@order = Order.new(order_params)
    	@order.customer_id = current_customer.id
    	if @order.save
		  	current_customer.cart_items.each do |cart_item|
		  	order_detail = OrderDetail.new
		  	order_detail.order_id = @order.id
		  	order_detail.item_id = cart_item.item_id
		  	order_detail.price = cart_item.item.price
		  	order_detail.amount = cart_item.amount
		  	order_detail.making_status = 0
    	  order_detail.save
    	  end
    	end
    	current_customer.cart_items.destroy_all
		if @order.postal_code.presence && @order.address.presence && @order.name.presence
			puts "-----------------------------test1"
		 	redirect_to public_orders_complete_path
		else
			puts "-----------------------------test2"
			redirect_to new_public_order_path
		end
	end

	def complete

	end

	private
    def order_params
      params.require(:order).permit(:address, :postal_code, :name, :total_payment, :shipping_cost, :payment_method, :status)
    end

end
