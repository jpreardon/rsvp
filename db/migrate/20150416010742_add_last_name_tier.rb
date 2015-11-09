class AddLastNameTier < ActiveRecord::Migration
  def change
    add_column :people, :last_name, :string
    add_column :people, :tier, :string
  end
end
