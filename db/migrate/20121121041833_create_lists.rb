class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :lists, :user_id
    add_index :lists, :post_id
  end
end
