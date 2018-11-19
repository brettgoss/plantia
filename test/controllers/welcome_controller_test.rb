require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "unauthenticated request should load index" do
    get unauthenticated_root_url()
    assert_response 200
  end

  test "unauthenticated request to dashboard should redirect to /" do
    get dashboard_index_url()
    assert_response 302
  end

end
