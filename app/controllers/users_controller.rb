class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def index
    @users =  User.paginate(page: params[:page])
  end

  def download
    pdf_filename = File.join(Rails.root, "app/assets/others/cuenta.pdf")
    send_file(pdf_filename, :filename => "your_document.pdf", :type => "application/pdf", disposition: 'inline')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if(signed_in?)
      flash.now[:success] = "You are already signed in.<br>Are you on drugs? :p".html_safe
      render 'static_pages/home'
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome"
      redirect_to @user
    else
      #flash[:error] = "No se puede agregar el usuario #{@user.email}.<BR>Verifique los siguientes errores"
      render 'new'
    end
  end

  def edit
    #@user = User.find(params[:id]);
  end

  def update
    #@user = User.find(params[:id])
    if(@user.update_attributes(params[:user]))
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if(user)
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    else
      flash[:error] = "Ocurrio un error al intentar eliminar un usuario inexistente."
      redirect_to users_path
    end
  end

  private
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: 'You have to sign-in first' unless signed_in?
      end

    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path, notice: 'You have not rights to edit other users' unless current_user? @user
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
