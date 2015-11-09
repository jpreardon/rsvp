class AddViewed < ActiveRecord::Migration
  def change
    add_column :parties, :viewed_at, :datetime
    add_column :parties, :updated_at, :datetime
  end
end
