class MailNewsController < ApplicationController
  def index
    if params[:email]
      email = params[:email]
      mail = MailingList.new
      unless mail.contact_present?(email)
        mail.add_contact(email)
        redirect_to mail_news_path, notice: 'Add Mailing List!!'
      else
        redirect_to mail_news_path, notice: 'Mail Address was register'
      end
    end

    if params[:remove_email]
      email = params[:remove_email]
      mail = MailingList.new
      unless mail.contact_present?(email)
        redirect_to mail_news_path, notice: 'Mail Address is not register'
      else
        mail.remove_contact(email)
        redirect_to mail_news_path, notice: 'Remove Your Mail to Mailing List!!'
      end
    end
  end
end
