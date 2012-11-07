class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => :nil
    add_column :users, :icon, :string, :default => :nil
  end
end
