class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :lang_a, :string
    add_column :users, :lang_b, :string
  end
end
