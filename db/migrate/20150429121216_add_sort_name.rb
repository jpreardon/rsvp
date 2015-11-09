class AddSortName < ActiveRecord::Migration
  def change
    add_column :parties, :sort_name, :string
  end
end
