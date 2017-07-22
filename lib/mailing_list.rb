class MailingList

  def initialize
    @sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def contact_list
    response = call_recipients.get().body
    contact_lists = recipients(response)
    contact_lists.map{ |i| i[:email] }
  end

  def contact_present?(email)
    params = set_email_to_json(email)
    response = call_recipients.search.get(query_params: params).body
    if recipients(response).count == 0
      false
    else
      contact_mail = recipients(response)[0][:email]
      email == contact_mail
    end
  end

  def add_contact(email)
    if self.contact_present?(email)
      false
    else
      params = set_email_to_json(email)
      response = call_recipients.post(request_body: [] << params).body
      JSON.parse(response, symbolize_names: true)[:error_count] == 0
    end
  end

  def remove_contact(email)
    unless self.contact_present?(email)
      false
    else
      params = set_email_to_json(email)
      response = call_recipients.search.get(query_params: params).body
      contact_id = recipients(response)[0][:id]
      call_recipients._(contact_id).delete()
      self.contact_present?(email) == false
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
