require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "index should redirect" do
    get welcome_index_url
    assert_response 302
  end

end
