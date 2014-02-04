class MicropostsController < ApplicationController
    before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user, only: [:destroy]

    def create
      @micropost = current_user.microposts.build(content: params[:micropost][:content])
      if(@micropost.save)
        flash.now[:success] = "Your message has been posted!!"
        redirect_to root_path
      else
        #@feed_items = User.find_by_remember_token(cookies[:remember_token]).microposts.limit(10).all.paginate(page: params[:page])
        @feed_items = User.find_by_remember_token(cookies[:remember_token]).microposts.limit(10).paginate(page: params[:page], per_page: 20, total_entries: 10)
        @micropost.content = ''
        render 'static_pages/home'
      end
    end

    def destroy
      @micropost.destroy
      redirect_back_or root_path
    end

    private
      def correct_user
        @micropost = current_user.microposts.find_by_id(params[:id])
        redirect_to root_path if @micropost.nil?
      end

end