class Public::ItemsController < ApplicationController
  def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
  @genres = Genre.all
  end

  def index
  @items = Item.all
  end
end
