# -*- coding: utf-8 -*-
#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---
#START:authorize
class StoreController < ApplicationController
#END:authorize
      #START:before_filter
      before_filter :find_cart, :except => :empty_cart
      #END:before_filter
  #START:index
  def index
    @products = Product.search(params)
  end
  #END:index

  def store_info
    
  end

  def send_mail
    ContactMailer.sent(params[:name], params[:name_kana], params[:email], params[:content]).deliver
  end

  #START:rti
  #START:add_to_cart
  def add_to_cart
    product = Product.find(params[:id])
    @current_item = @cart.add_product(product)
      respond_to do |format|
        format.js if request.xhr?
        format.html {redirect_to_index}
      end
  rescue ActiveRecord::RecordNotFound
    logger.error("無効な商品#{params[:id]}にアクセスしようとしました")
    redirect_to_index("無効な商品です")
  end
  #END:add_to_cart

#START:cart
  #START:empty_cart
  #START:checkout
  def checkout
    if @cart.items.empty?
      redirect_to_index("カートは現在空です")
    else
      @order = Order.new
    end
  end
  #END:checkout

  def confirm  
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(@cart)

    if @order.address == "郵便番号を入力すると番地情報を除いて住所が自動で入力されます"
      @order.address = ""
    end
    if @order.send_address == "郵便番号を入力すると番地情報を除いて住所が自動で入力されます"
      @order.send_address = ""
    end

    if @order.remark == "ラベル情報等必要事項があれば記載して下さい"
      @order.remark = ""
    end

    Order::PAYMENT_TYPES.each do |paytypes|
      if paytypes[1] == @order.pay_type
        @order.pay_type_name = paytypes[0]
        break;
      end
    end

    Order::TIME_ZONE.each do |timezone|
      if timezone[1] == @order.time_zone
        @order.time_zone_name = timezone[0]
        break;
      end
    end

    if @order.is_send()
        @order.is_send = true
    end

    if @order.valid?
      session[:order] = @order
      render :action => 'confirm'
    else  
      render :action => 'checkout'
    end  
  end
  
  #START:save_order
  def save_order

    @order = session[:order]
    
    if @order.save
      OrderMailer.sent(@order).deliver
      session[:cart] = nil
      
      redirect_to_index(I18n.t('flash.thanks'))
    else
      render :action => 'checkout'
    end
  end
  #END:save_order

  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end
  #END:empty_cart

private

  #START:redirect_to_index
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end
  #END:redirect_to_index
  #END:rti

      #START:find_cart
      def find_cart
        @cart = (session[:cart] ||= Cart.new)
      end
      #END:find_cart
#END:cart

#START:authorize
  #...
protected

  def authorize
  end
end
#END:authorize# -*- coding: utf-8 -*-
