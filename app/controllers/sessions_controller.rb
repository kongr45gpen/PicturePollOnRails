class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if not user
      flash.now[:error] = 'Invalid username'
      render 'new'
    elsif not user.authenticate(params[:session][:password])
      flash.now[:error] = 'Incorrect password'
      render 'new'
    else
      flash.now[:success] = 'Congrats!'
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
