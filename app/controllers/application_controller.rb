class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :display_prelaunch_if_too_soon, except: [:robots]

  def robots
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render text: robots, layout: false, content_type: "text/plain"
  end

  protected

  def display_prelaunch_if_too_soon
    if Rails.env.production? && !launched?
      render text: File.read(Rails.root + "config/pre-launch-page.html"), layout: false, content_type: "text/html"
    end
  end

  def launched?
    Time.now > Time.new(2013, 8, 21)
  end

end
