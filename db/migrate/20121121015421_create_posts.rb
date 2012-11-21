class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :comment
      t.binary :photo
      t.integer :star
      t.references :restarurant
      t.references :user

      t.timestamps
    end
    add_index :posts, :restarurant_id
    add_index :posts, :user_id
  end
end
