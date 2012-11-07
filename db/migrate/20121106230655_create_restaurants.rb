class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name,         :null => false
      t.string :tel
      t.string :url
      t.string :location,     :null => false
      t.string :address
      t.text :business_hour
      t.text :holiday
      t.integer :capacity
      t.boolean :credit
      t.boolean :parking

      t.timestamps
    end
  end
end
