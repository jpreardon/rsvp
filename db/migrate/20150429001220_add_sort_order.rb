class AddSortOrder < ActiveRecord::Migration
  def change
    add_column :people, :sort_order, :integer
  end
end
