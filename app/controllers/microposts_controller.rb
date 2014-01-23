class MicropostsController < ApplicationController
    before_filter :signed_in_user

    def create
      @micropost = current_user.microposts.build(content: params[:content])
      if(@micropost.save)
        flash.now[:success] = "Your message has been posted!!"
        redirect_to root_path
      else
        render 'static_pages/home'
      end
    end

    def destroy
    end
end