class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user
      if user.authenticate(params[:session][:password])
	flash.now['Congrats!'] = :success
	sign_in user
	redirect_to user
      else
	flash.now['Incorrect password'] = :error
	render 'new'
      end
    else
      flash.now['Invalid username'] = :error
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
