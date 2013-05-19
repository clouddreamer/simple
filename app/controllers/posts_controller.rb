class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :signed_in_user, only: [:create, :destroy]


  def create
   @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    end
  end
end
