# -*- coding: utf-8 -*-
class ContactMailer < ActionMailer::Base
  default :from => "njunichiro@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.confirm.subject
  #
  def confirm(name, name_kana, content)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.sent.subject
  #
  def sent(name, name_kana, email, content)
    @name = name
    @name_kana = name_kana
    @content = content
    @email = email
    
    # mail :to => "njunichiro@gmail.com", :subject => "【BEERS NAKAMURA】 注文受け付けました"
    mail :to => "njunichiro@gmail.com", :subject => "問い合わせです。"
  end
end
