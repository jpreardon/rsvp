class ChangePersonRsvpName < ActiveRecord::Migration
  def change
    rename_column :people, :rsvp, :attending
  end
end
