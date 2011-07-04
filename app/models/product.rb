# -*- coding: utf-8 -*-
class Product < ActiveRecord::Base
  has_many :line_items

  image_accessor :cover_image
  image_accessor :detail_image

  named_scope :by_price, lambda{|price| {:conditions => ['price <= ?', price]} }

  validates :code,  :presence => true,:uniqueness=>true
  validates :name,  :presence => true,:uniqueness=>true
  validates :description, :presence => true
  # validates :cover_image, :presence => true, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'はGIF、JPG、PNG画像のURLでなければなりません'}
  # validates :detail_image, :presence => true, :format => { :with => %r{\.(gif|jpg|png)$}i, :message => 'はGIF、JPG、PNG画像のURLでなければなりません'}
  validates :price, :numericality => {:only_integer => true, :greater_than => 1}

# protected
#   def price_must_be_at_least_a_cent
#     errors.add(:price, 'は最小でも0.01以上でなければなりません') if price.nil? ||
#                        price < 0.01
#   end

  def self.search(params = {})
    exec_scopes = []  # [実行するスコープ名(シンボル), 引数] を格納する配列

    # if params[:deleted] == true
    #   exec_scopes << [:deleted]
    # else
    #   exec_scopes << [:active]
    # end

    if params[:cond_price] and ! params[:cond_price].empty?
      exec_scopes << [:by_price, params[:cond_price]]
    end
  
    # 実行するスコープがない場合
    if exec_scopes.size == 0
      return Product.scoped
    end

    # named_scopeをまとめて実行
    exec_scopes.reverse.inject(self){|obj, exec_scope|
      scope = exec_scope.shift
      args = exec_scope

      if args.size > 0
        obj = obj.send(scope, *args)
      else
        obj = obj.send(scope)
      end
    }
  end
end
