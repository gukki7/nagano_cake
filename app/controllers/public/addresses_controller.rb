class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    if @address.save
       puts "保存に成功しました"
    else
       puts "保存に失敗しました"
    end
  end

  def update
  end

  def destroy
  end

  def edit
  end
  
  private
  # ストロングパラメータ
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
