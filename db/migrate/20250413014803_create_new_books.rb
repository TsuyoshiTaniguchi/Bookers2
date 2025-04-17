class CreateNewBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :new_books do |t|
      t.text :opinion
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end
  end
end