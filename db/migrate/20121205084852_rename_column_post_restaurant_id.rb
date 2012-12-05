class RenameColumnPostRestaurantId < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.rename :restarurant_id, :restaurant_id
    end
    remove_index :posts, :restarurant_id
    add_index :posts, :restaurant_id
  end
end
