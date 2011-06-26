# -*- coding: utf-8 -*-
#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:salable
#START:has_many
class Product < ActiveRecord::Base
  has_many :line_items
  # ...
  #END:has_many

  image_accessor :cover_image
  image_accessor :detail_image

  def self.find_products_for_sale
    find(:all, :order => "name")
  end

  # validation stuff...
#END:salable

  validates :title,  :presence => true,:uniqueness=>true
  validates :description, :presence => true
  validates :cover_image, :presence => true
  validates :detail_image, :presence => true
  validates :price, :numericality => {:only_integer => true, :less_than => 1}, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'はGIF、JPG、PNG画像のURLでなければなりません' }  

# protected
#   def price_must_be_at_least_a_cent
#     errors.add(:price, 'は最小でも0.01以上でなければなりません') if price.nil? ||
#                        price < 0.01
#   end
#END:val2a
#END:validation

end
