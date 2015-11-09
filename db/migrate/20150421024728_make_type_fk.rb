class MakeTypeFk < ActiveRecord::Migration
  def change
    remove_column :people, :type
    change_table(:people) do |t|
      t.belongs_to :type, index: true
    end
  end
end
