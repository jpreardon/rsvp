class ChangeTierToPrice < ActiveRecord::Migration
  def change
    rename_column :people, :tier, :type
  end
end
