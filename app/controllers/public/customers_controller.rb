class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def create
    @customers = Customer.all
    @customer = Customer.new(customer_params)
    if @customer.save
       puts "保存に成功しました"
    else
       puts "保存に失敗しました"
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
       flash[:success] = "登録情報を変更しました。"
       redirect_to public_customers_my_page_path
    else
       render 'edit'
    end
  end


  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to public_root_path
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
    end

end
