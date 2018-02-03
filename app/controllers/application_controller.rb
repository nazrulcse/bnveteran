class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #layout 'new_design', :except => [:sign_up, :sign_in]
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?


  BRAND_NAME = 'BN Veteran'.freeze
  def meta_title(title)
    [title, BRAND_NAME].reject(&:empty?).join(' | ')
  end

  def access_denied(exception)
     redirect_to new_admin_user_session_path, alert: exception.message
  end

  protected

  def layout_by_resource
    if devise_controller?
      "custom_design"
    else
      "new_design"
    end
  end

  def configure_permitted_parameters
    # binding.pry
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password_confirmation, :officer_no, :email, :phone_number])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :officer_no, :email, :remember_me])
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
    end
  end

  include PublicActivity::StoreController
end
