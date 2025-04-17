class DropNewBooks < ActiveRecord::Migration[6.1]
  def change
    drop_table :new_books
  end
end
