class SessionsController < ApplicationController

  # Login Logic
  def create
    # Check the credentials of the login attempt
    user = User.authenticate_with_credentials(params[:sessions][:email], params[:sessions][:password])
    # If the user exists AND the password entered is correct.
    if user
      # Save the user id inside the browser cookie.
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/'
    end
  end

  # Logout Logic
  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
