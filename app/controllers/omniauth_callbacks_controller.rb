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

  def github
    @user = User.find_for_github_oauth request.env['omniauth.auth']

    if @user.persisted?
      flash[:notice] = 'Successfully signed in through GitHub!'
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url(:oauth => 'github')
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth2 request.env['omniauth.auth']

    if @user.persisted?
      flash[:notice] = 'Successfully signed in through Google!'
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url(:oauth => 'google')
    end
  end

  def facebook
    @user = User.find_for_facebook_oauth request.env['omniauth.auth']

    if @user.persisted?
      flash[:notice] = 'Successfully signed in through Facebook!'
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url(:oauth => 'facebook')
    end
  end
end
