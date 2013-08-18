class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.find_for_twitter_oauth request.env['omniauth.auth']

    if @user.persisted?
      flash[:notice] = 'Successfully signed in through Twitter!'
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url(:oauth => 'twitter')
    end
  end
end
