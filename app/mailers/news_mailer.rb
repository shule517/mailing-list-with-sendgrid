class NewsMailer < ApplicationMailer
  default :from => '3sho7mi8@gmail.com'

  def send_signup_email(user)
    xsmtp_api_params = { to: ['3sho7mi8@gmail.com', 'hiro.pinot@gmail.com'] }
    header['X-SMTPAPI'] = JSON.pretty_generate(xsmtp_api_params)

    @user = user
    mail( to: @user.email, subject: 'Thanks for signing up for our amazing app!!' )
  end
end
