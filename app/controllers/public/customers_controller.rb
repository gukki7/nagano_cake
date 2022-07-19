class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])

  end
  
  def create
    @customers = Customer.all
    @customer = Customer.new(user_params)
  if @customer.save
    puts "保存に成功しました"
  else
    puts "保存に失敗しました"
  end
  end
end
