class DeviseUpdateUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string
    add_column :users, :birthday, :date
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :locale, :string
  end
end
