class FeedbackMailer < ActionMailer::Base
  default from: "no-reply@doored.ca"

  def feedback(message, email)
    @message = message
    @email = email
    mail(:to => '"Justin Bull" <me@justinbull.ca>', :subject => "Doored.ca Feedback!")
  end
end
