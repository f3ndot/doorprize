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
end
