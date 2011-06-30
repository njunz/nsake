class AddDeliveryDateToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :delivery_date, :string
    add_column :orders, :time_zone, :string
  end

  def self.down
    remove_column :orders, :time_zone
    remove_column :orders, :delivery_date
  end
end
