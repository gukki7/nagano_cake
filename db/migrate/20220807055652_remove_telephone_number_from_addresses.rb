class RemoveTelephoneNumberFromAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_column :addresses, :telephone_number, :string
  end
end
