class SessionsController < ApplicationController
  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    if Customer.find_by_email_and_password(params[:email],params[:password])

      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      @customer = Customer.find_by_email_and_password(params[:email],params[:password])
      session[:customer_id] = @customer.id
      redirect_to '/show_profile'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to '/login'
  end
end

# Insert code here