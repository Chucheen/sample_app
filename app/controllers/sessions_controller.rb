class SessionsController < ApplicationController

  def new
    #@userName = params[:session][:email];;
  end

  def create

    sessionHash = params[:session]
    user = User.find_by_email sessionHash[:email]

    if(user)
      if(user.authenticate(sessionHash[:password]))
        flash[:success] = "Welcome back #{user.name}<#{user.email}>"
        sign_in user
        redirect_back_or user
      else
        flash.now[:error] = "Incorrect login: Bad password"
        render 'new'
      end
    else
      flash.now[:error] = "Incorrect login: User #{sessionHash[:email]} Doesn't exist"
      render 'new'
    end

  end

  def destroy
    signout
    redirect_to signin_path
  end

end
