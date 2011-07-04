class AddDateinfoToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :year, :string
    add_column :orders, :month, :string
    add_column :orders, :day, :string
  end

  def self.down
    remove_column :orders, :day
    remove_column :orders, :month
    remove_column :orders, :year
  end
end
