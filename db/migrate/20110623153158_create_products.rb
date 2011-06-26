class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :code
      t.string :name
      t.text :description
      t.string :cover_image_uid
      t.string :cover_image_name
      t.string :detail_image_uid
      t.string :detail_image_name

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
