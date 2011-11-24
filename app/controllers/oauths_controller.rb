class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    session[:return_to_url] = request.env["HTTP_REFERER"]
    provider = params[:provider]
    if @user = login_from(provider)
      session[:access_token] = Koala::Facebook::OAuth.new("304055022939018","b6a526c78d6a33d8b1e43704dfb9b63a", 'http://localhost:3000/oauth/callback?provider=facebook').get_access_token(params[:code])
      #session[:return_to_url] = request.env["HTTP_REFERER"]
      redirect_back_or_to(home_path, :notice => "Logged in from #{provider.titleize}!")
      #redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        @user.activate!
        reset_session # protect from session fixation attack
        if login_from(provider)
          track! :signup
          redirect_to home_path, :notice => "Logged in from #{provider.titleize}!"
        end
      rescue
        redirect_to login_path(:anchor => 'facebook-form'), :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end
end