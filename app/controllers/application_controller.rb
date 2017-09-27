class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_customer
    if session[:customer_id] then
      @current_customer ||= Customer.find(session[:customer_id])
    end
  end

  def current_admin
    if session[:admin_id] then
      @current_admin ||= Admin.find(session[:admin_id])
    end
  end

  def current_superadmin
    if session[:superadmin_id] then
      @current_superadmin ||= Superadmin.find(session[:superadmin_id])
    end
  end

  helper_method :current_customer
  helper_method :current_admin
  helper_method :current_superadmin


  def authorize
    redirect_to '/login' unless current_user
  end
end
