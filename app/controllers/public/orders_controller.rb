class Public::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @cart_items = current_customer.cart_items
  end

  def comfirm
    @cart_items = CartItem.all

		customer = current_customer

		# sessionを使ってデータを一時保存
		session[:order] = Order.new

		cart_items = current_customer.cart_items

		# total_paymentのための計算
		sum = 0
		cart_items.each do |cart_item|
			sum += (cart_item.item.price_without_tax * 1.1).floor * cart_item.quantity
		end

		session[:order][:shipping_cost] = 800
		session[:order][:total_payment] = sum + session[:order][:shipping_cost]
		session[:order][:status] = 0
		session[:order][:id] = current_customer.id
		# ラジオボタンで選択された支払方法のenum番号を渡している
		session[:order][:payment_method] = params[:method].to_i

		# ラジオボタンで選択されたお届け先によって条件分岐
		destination = params[:a_method].to_i

		# ご自身の住所が選択された時
		if destination == 0

			session[:order][:postal_code] = customer.postal_code
			session[:order][:address] = customer.address
			session[:order][:name] = customer.last_name + customer.first_name

		# 登録済住所が選択された時
		elsif destination == 1

			address = ShippingAddress.find(params[:shipping_address_for_order])
			session[:order][:post_code] = address.postal_code
			session[:order][:address] = address.address
			session[:order][:name] = address.name

		# 新しいお届け先が選択された時
		elsif destination == 2

			session[:new_address] = 2
			session[:order][:post_code] = params[:post_code]
			session[:order][:address] = params[:address]
			session[:order][:name] = params[:name]

		end

		# お届け先情報に漏れがあればリダイレクト
		if session[:order][:post_code].presence && session[:order][:address].presence && session[:order][:name].presence
			redirect_to new_customers_order_path
		else
			redirect_to public_orders_complete_path
		end
  end


end
