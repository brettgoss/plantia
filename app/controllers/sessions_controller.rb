class SessionsController < ApplicationController

  def create
    user = User.authenticate_with_credentials(params[:sessions][:email], params[:sessions][:password])
    # If the user exists AND the password entered is correct.
    if user
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
