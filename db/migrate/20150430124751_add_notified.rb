class AddNotified < ActiveRecord::Migration
  def change
    add_column :parties, :notified_at, :datetime
  end
end
