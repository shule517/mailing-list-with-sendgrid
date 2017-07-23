class MailNewsController < ApplicationController
  def index
    if params[:email]
      email = params[:email]
      mail = MailingList.new
      unless mail.contact_present?(email)
        mail.add_contact(email)
        redirect_to mail_news_path, notice: 'Registered!!'
      else
        redirect_to mail_news_path, notice: 'Email address already registered.'
      end
    end

    if params[:remove_email]
      email = params[:remove_email]
      mail = MailingList.new
      unless mail.contact_present?(email)
        redirect_to mail_news_path, notice: 'Registration failed...'
      else
        mail.remove_contact(email)
        redirect_to mail_news_path, notice: 'Email address removed!!'
      end
    end
  end

  def list
    mail = MailingList.new
    @contacts = mail.contact_list
  end
end
