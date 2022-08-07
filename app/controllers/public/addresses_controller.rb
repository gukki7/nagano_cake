class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_addresses_path
    else

    end
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    address.customer_id = current_customer.id
    redirect_to public_addresses_path
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
    @address = Address.find(params[:id])
  end

  private
  # ストロングパラメータ
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
