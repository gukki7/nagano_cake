class RemoveStatusFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :status, :integer
    add_column :orders, :status, :integer, default: 0, null: false
  end
end
