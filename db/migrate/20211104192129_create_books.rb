class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.text :title
      t.text :author
      t.text :genre
      t.text :sub_genre
      t.integer :pages
      t.text :publisher
      t.integer :copies

      t.timestamps
    end
  end
end
