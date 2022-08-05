class Public::HomesController < ApplicationController
  def top
    @orders = Order.where("created_at" === Date.today)
  end

  def about
  end
end

