class AddDoingToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :doing, :integer
  end

  def self.down
    remove_column :users, :doing
  end
end
