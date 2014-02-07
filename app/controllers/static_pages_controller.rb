class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @micropost = params[:micropost] ||= current_user.microposts.build
      @micropost.content = ""
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
