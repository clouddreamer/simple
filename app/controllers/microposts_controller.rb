class MicropostsController < ApplicationController
  before_filter :signed_in_user
   before_filter :correct_user,   only: :destroy


  def create
 @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "タイムラインを作成しましたよ〜"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

   def destroy
    @micropost.destroy
    redirect_to root_url
  end

  def index
     @microposts = Micropost.paginate(page: params[:page])
  end

  def search
    @microposts = Micropost.search(params[:q])
    render 'index'
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      
      redirect_to root_url if @micropost.nil?
    end
end