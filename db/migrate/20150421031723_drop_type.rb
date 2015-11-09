class DropType < ActiveRecord::Migration
  def change
    drop_table :types
  end
end
