class SessionsController < ApplicationController
	  def new
  end

  def create
  	user = User.find_by_userID(params[:session][:userID])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'ユーザーIDとパスワードが合わない '
      render 'new'
    end
  end

   def destroy
    sign_out
    redirect_to root_url
  end
end
