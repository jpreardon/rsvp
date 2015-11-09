class AddRsvpByDate < ActiveRecord::Migration
  def change
    add_column :parties, :rsvp_by, :datetime
  end
end
