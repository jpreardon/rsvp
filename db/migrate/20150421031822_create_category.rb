class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    end
    rename_column :people, :type_id, :category_id
  end
end
