class Public::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.where("created_at" === Date.today)
end

  def about
  end
end

