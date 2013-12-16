class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]

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
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
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
end
