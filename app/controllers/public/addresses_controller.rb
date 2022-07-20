class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def edit
  end
end
