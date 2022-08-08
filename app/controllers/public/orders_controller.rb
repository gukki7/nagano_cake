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
		customer = current_customer
		session[:order] = Order.new

		cart_items = current_customer.cart_items

		sum = 0
		cart_items.each do |cart_item|
			sum += cart_item.item.price * cart_item.amount
		end

		session[:order][:shipping_cost] = 800
		session[:order][:total_payment] = sum + session[:order][:shipping_cost]
		session[:order][:status] = 0
		session[:order][:id] = current_customer.id
		session[:order][:payment_method] = params[:method].to_i

		destination = params[:a_method].to_i

		if destination == 0

			session[:order][:postal_code] = customer.postal_code
			session[:order][:address] = customer.address
			session[:order][:name] = customer.last_name + customer.first_name

		elsif destination == 1
			address = Address.find(params[:address_for_order])
			session[:order][:postal_code] = address.postal_code
			session[:order][:address] = address.address
			session[:order][:name] = address.name

		elsif destination == 2

			session[:new_address] = 2
			session[:order][:postal_code] = params[:postal_code]
			session[:order][:address] = params[:address]
			session[:order][:name] = params[:name]
		end
    	@cart_items = CartItem.all
	end

	def create
    	@orders = Order.all
    	@order = Order.new(order_params)
    	if @order.save
		  @order_details.each do |item|
		  @order_item = OrderItem.new
    	  @order_item.save
    	  end
    	end
		if session[:order][:postal_code].presence && session[:order][:address].presence && session[:order][:name].presence
		 	redirect_to new_customers_order_path
		else
			redirect_to public_orders_complete_path
		end
	end

	private
    def oredr_params
      params.require(:order).permit(:address, :total_payment, :status)
    end

end
