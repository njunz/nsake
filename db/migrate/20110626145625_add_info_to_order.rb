class AddInfoToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :name_kana, :string
    add_column :orders, :tel, :string
    add_column :orders, :zip, :string
    add_column :orders, :email_confirm, :string
    add_column :orders, :send_name, :string
    add_column :orders, :send_name_kana, :string
    add_column :orders, :send_tel, :string
    add_column :orders, :send_zip, :string
    add_column :orders, :send_address, :text
    add_column :orders, :remark, :text
    add_column :orders, :is_adult, :boolean
  end

  def self.down
    remove_column :orders, :is_adult
    remove_column :orders, :remark
    remove_column :orders, :send_address
    remove_column :orders, :send_zip
    remove_column :orders, :send_tel
    remove_column :orders, :send_name_kana
    remove_column :orders, :send_name
    remove_column :orders, :email_confirm
    remove_column :orders, :zip
    remove_column :orders, :tel
    remove_column :orders, :name_kana
  end
end
