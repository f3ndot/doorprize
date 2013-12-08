class SurveysController < ApplicationController
  def dismiss
    authorize! :dismiss, :surveys

    if user_signed_in?
      current_user.survey_dismissed = true
      current_user.save!
    else
      cookies.permanent[:survey] = "dismiss"
    end
    render nothing: true
  end
end
