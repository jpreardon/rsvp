class AddRsvp < ActiveRecord::Migration
  def change
    add_column :people, :rsvp, :boolean
  end
end
