class ApplicationController < ActionController::Base
  # before_action :basic_auth, if: :production?

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 拾い物 未ログイン時の遷移先指定？
  def authenticate
    return if logged_in?
    return_to root_path
  end
  def logged_in?
    !!session[:user_id]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name])
  end

  # private

  # def production?
  #   Rails.env.production?
  # end

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == Rails.application.credentials[:basic_auth][:user] &&
  #     password == Rails.application.credentials[:basic_auth][:pass]
  #   end
  # end
end
