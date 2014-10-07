class UserController < ApplicationController
  def login
    redirect_to request_token.authorize_url
  end

  def auth
   @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

   session.delete(:request_token)

    # at this point in the code is where you'll need to create your user account and store the access token
    user = User.find_or_create_by(twitter_handle: @access_token.params[:screen_name])

    if user.token == nil
      user.token = @access_token.token
      user.token_secret = @access_token.secret
      user.save!
    end
    session[:user_id] = user.id
    redirect_to root_path
  end

end
