# frozen_string_literal: true

module SpecTestHelper
  def login_as(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  def current_user
    User.find(request.session[:user])
  end
end
