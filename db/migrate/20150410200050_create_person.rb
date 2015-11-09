class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.belongs_to :party, index: true
    end
  end
end
