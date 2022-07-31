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
    address = Address.find(params[:id])  # データ（レコード）を1件取得
    if address.delete
    redirect_to public_addresses_path,
    notice: 'successfully'
    else
    render :index
    end
  end

  def edit
  end
  
  private
  # ストロングパラメータ
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
