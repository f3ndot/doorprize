class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  check_authorization unless: :devise_controller?

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :display_prelaunch_if_too_soon
  # Short term fix for cancan 1.6.10 and rails 4.0.0 strong params problem
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    alert_message = "<i class='icon-minus-sign'></i> <strong>Access Denied.</strong> ".html_safe
    alert_message << exception.message
    redirect_to root_url, :alert => alert_message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  def display_prelaunch_if_too_soon
    if params[:controller] != 'pages' && Rails.env.production? && !launched?
      render text: File.read(Rails.root + "config/pre-launch-page.html"), layout: false, content_type: "text/html"
    end
  end

  def launched?
    # The morning of August 21st in Toronto (Eastern Time)
    Time.now >= Time.new(2013, 8, 21, 0, 0, 0, '-04:00')
  end

end
