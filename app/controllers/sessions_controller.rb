class SessionsController < ApplicationController
  def new
    if current_superadmin
      redirect_to '/superadmin_profile'
    elsif current_admin
      redirect_to '/admin_profile'
    elsif current_customer
      redirect_to '/customer_profile'
    end
  end

  def create
    # If the user exists AND the password entered is correct.
    # Save the user id inside the browser cookie. This is how we keep the user
    # logged in when they navigate around our website.
    if Superadmin.find_by_email_and_password(params[:email],params[:password])
      @superadmin = Superadmin.find_by_email_and_password(params[:email],params[:password])
      session[:superadmin_id] = @superadmin.id
      redirect_to '/superadmin_profile'

    elsif Admin.find_by_email_and_password(params[:email],params[:password])
      @admin = Admin.find_by_email_and_password(params[:email],params[:password])
      session[:admin_id] = @admin.id
      redirect_to '/admin_profile'

    elsif Customer.find_by_email_and_password(params[:email],params[:password])
      @customer = Customer.find_by_email_and_password(params[:email],params[:password])
      session[:customer_id] = @customer.id
      redirect_to '/customer_profile'

    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end


  def destroy
    session[:customer_id] = nil
    session[:admin_id] = nil
    session[:superadmin_id] = nil
    redirect_to '/login'
  end
end

# Insert code here