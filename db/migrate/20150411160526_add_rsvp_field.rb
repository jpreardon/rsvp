class AddRsvpField < ActiveRecord::Migration
  def change
    add_column :parties, :rsvp, :boolean
  end
end
