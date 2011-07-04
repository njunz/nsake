# -*- coding: utf-8 -*-
#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:has_many
#START:select
#START:validate
class Order < ActiveRecord::Base

  attr_accessor :email_confirmation, :pay_type_name, :time_zone_name, :is_send
  
  has_many :line_items

  PAYMENT_TYPES = [[ "代金引換", "por" ], [ "銀行振込", "bank" ],]
  YEAR = [["2011", "2011"], ["2012", "2012"],]
  MONTH = [["1", "1"], ["2", "2"], ["3", "3"], ["4", "4"], ["5", "5"], ["6", "6"], ["7", "7"], ["8", "8"], ["9", "9"], ["10", "10"], ["11", "11"], ["12", "12"]]
  DAY = [["1", "1"], ["2", "2"], ["3", "3"], ["4", "4"], ["5", "5"], ["6", "6"], ["7", "7"], ["8", "8"], ["9", "9"], ["10", "10"],
    ["11", "11"], ["12", "12"], ["13", "13"], ["14", "14"], ["15", "15"], ["16", "16"], ["17", "17"], ["18", "18"], ["19", "19"], ["20", "20"],
    ["21", "21"], ["22", "22"], ["23", "23"], ["24", "24"], ["25", "25"], ["26", "26"], ["27", "27"], ["28", "28"], ["29", "29"], ["30", "30"], ["31", "31"],]
  TIME_ZONE = [["指定しない", "0"], ["9時〜12時", "1"], ["12時〜15時", "2"], ["16時〜19時", "3"]]

  # def after_initialize
  #   for num in 1..12
  #     MONTH << ["#{num}", "#{num}"]
  #   end

  #   for num in 1..31
  #     DAY << ["#{num}", "#{num}"]
  #   end
  # end

  # フォーム値の検証
  validates :name, :presence => true
  validates :pay_type, :presence => true
  validates :name_kana, :presence => true
  validates :zip, :presence => true
  validates :address, :presence => true
  validates :is_adult, :presence => true
  validates :year, :presence => true
  validates :month, :presence => true
  validates :day, :presence => true
  validates :email, :presence => true, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :tel, :numericality => {:only_integer => true}, :format => { :with => /^[0-9]+$/ }

  validates_confirmation_of :email

  # 各種SELECTボックス
  validates_inclusion_of :pay_type, :in =>
    PAYMENT_TYPES.map {|disp, value| value}
  
  validates_inclusion_of :year, :in =>
    YEAR.map {|disp, value| value}
  
  validates_inclusion_of :month, :in =>
    MONTH.map {|disp, value| value}
  
  validates_inclusion_of :day, :in =>
    DAY.map {|disp, value| value}

  #START:add_line_items_from_cart
  def add_line_items_from_cart(cart)
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
  end

  def is_send
    ! send_name.empty? or ! send_name_kana.empty? or ! send_tel.empty? or ! send_zip.empty? or ! send_address.empty? 
  end

  def total_price

    total_price = 0
    
    line_items.each do |e|
      total_price += e.total_price
    end

    total_price.to_i
  end
end

