class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.integer :user_id
      t.string :description
      t.integer :time

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
