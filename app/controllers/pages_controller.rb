class PagesController < ApplicationController
  def robots
    authorize! :robots, :pages
    robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
    render text: robots, layout: false, content_type: "text/plain"
  end

  def privacy
    authorize! :privacy, :pages
    render text: 'Coming soon', layout: true
  end

  def terms
    authorize! :terms, :pages
    render text: 'Coming soon', layout: true
  end

  def prelaunch
    authorize! :prelaunch, :pages
    render text: File.read(Rails.root + "config/pre-launch-page.html"), layout: false, content_type: "text/html"
  end

  def why
    authorize! :why, :pages
  end

  def feedback
    authorize! :feedback, :pages

    begin
      FeedbackMailer.feedback(params[:message], params[:email]).deliver!
    rescue Exception => e
      respond_to do |format|
        format.json { render status: :internal_server_error, text: e.to_s }
      end
      return
    end

    respond_to do |format|
      format.json { render json: "Thanks for the feedback!".to_json }
    end
  end
end
