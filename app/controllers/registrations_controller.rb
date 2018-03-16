class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  protected

  def after_sign_up_path_for(resource)
    '/users/sign_in' # Or :prefix_to_your_route
  end

  def after_inactive_sign_up_path_for(resource)
    '/users/sign_in' # Or :prefix_to_your_route
  end


end