# -*- coding: utf-8 -*-
class OrderMailer < ActionMailer::Base
  default :from => "njunichiro@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirm.subject
  #
  def confirm(order)
    @order = order
    mail :to => "njunichiro@gmail.com", :subject => "注文を受けました。ありがとうございます。"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.sent.subject
  #
  def sent(order)
    @order = order
    mail :to => "njunichiro@gmail.com", :subject => "注文を受けました"
  end
end
