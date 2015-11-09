class RemoveLastName < ActiveRecord::Migration
  def change
    remove_column :people, :last_name
  end
end
