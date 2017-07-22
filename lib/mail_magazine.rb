class MailMagazine
  attr_accessor = :mailing_lists

  def initialize
    @sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def lists
    response = call_recipients.get().body
    mailing_lists = recipients(response)
    mailing_lists.map{ |i| i[:email] }
  end

  def member_present?(email)
    params = set_email_to_json(email)
    response = call_recipients.search.get(query_params: params).body
    if recipients(response).count == 0
      false
    else
      @member_mail = recipients(response)[0][:email]
      email == @member_mail
    end
  end

  def add_member(email)
    if self.member_present?(email)
      false
    else
      params = set_email_to_json(email)
      response = call_recipients.post(request_body: [] << params).body
      JSON.parse(response, symbolize_names: true)[:error_count] == 0
    end
  end

  def remove_member(email)
    unless self.member_present?(email)
      false
    else
      params = set_email_to_json(email)
      response = call_recipients.search.get(query_params: params).body
      member_id = recipients(response)[0][:id]
      call_recipients._(member_id).delete()
      self.member_present?(email) == false
    end
  end

  private

    def recipients(body)
      values = JSON.parse(body, symbolize_names: true)
      values[:recipients] if values.keys == [:recipients]
    end

    def call_recipients
      @sg.client.contactdb.recipients
    end

    def set_email_to_json(email)
      json = JSON.generate({"email" => email})
      JSON.parse(json)
    end
end
