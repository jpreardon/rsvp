class AddCategories < ActiveRecord::Migration
  def change
    execute "insert into categories (name) values ('Adult')"
    execute "insert into categories (name) values ('Child')"
    execute "insert into categories (name) values ('Vendor')"
  end
end
