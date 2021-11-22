class AddDatesToUserbooks < ActiveRecord::Migration[6.1]
  def change
    add_column :user_books, :checkoutdate, :date
    add_column :user_books, :returndate, :date
  end
end
