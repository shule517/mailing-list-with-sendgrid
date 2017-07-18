require 'test_helper'

class MailNewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mail_news_index_url
    assert_response :success
  end

end
