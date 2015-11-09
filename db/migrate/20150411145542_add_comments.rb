class AddComments < ActiveRecord::Migration
  def change
    add_column :parties, :comments, :text
  end
end
