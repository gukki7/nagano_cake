class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_item.all
  end
end
