class AddCheckoutDateToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :checkoutdate, :date
  end
end
