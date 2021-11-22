class AddUsersListToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :checkedoutusers, :integer
  end
end
