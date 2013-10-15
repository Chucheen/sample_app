class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:succes] = "¡Bienvenido #{@user.name.upcase}!"
      redirect_to @user
    else
      flash[:error] = "No se puede agregar el usuario #{@user.email}.<BR>Verifique los siguientes errores"
      render 'new'
    end
  end
end
