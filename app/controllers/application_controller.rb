class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :display_prelaunch_if_too_soon, except: [:robots, :privacy, :terms]

  def robots
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render text: robots, layout: false, content_type: "text/plain"
  end

  def privacy
    render text: 'Coming soon', layout: true
  end

  def terms
    render text: 'Coming soon', layout: true
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  def display_prelaunch_if_too_soon
    if Rails.env.production? && !launched?
      render text: File.read(Rails.root + "config/pre-launch-page.html"), layout: false, content_type: "text/html"
    end
  end

  def launched?
    # The morning of August 21st in Toronto (Eastern Time)
    Time.now >= Time.new(2013, 8, 21, 0, 0, 0, '-04:00')
  end

end
