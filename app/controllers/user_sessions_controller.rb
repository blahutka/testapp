class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user_session = User.new
  end

  def create
    respond_to do |format|
      if @user_session = login(params[:user_session][:email], params[:user_session][:password],
                               params[:user_session][:remember])
        format.html {track!(:signup); redirect_back_or_to(dashboard_path, :notice => 'Login successfull.') }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
      end
    end
  end

  def destroy
    logout
    redirect_to(login_path(:anchor => 'login-form'), :notice => 'Logged out!')
  end

end
