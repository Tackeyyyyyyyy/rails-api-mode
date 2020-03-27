class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  
  def index
    posts = Post.order(created_at: :desc)
    json_response posts
  end
  
  def show
    json_response @post
  end
  
  def create
    post = Post.new(post_params)
    if post.save
       json_response post
    else
       json_response post
    end
  end
  
  def destroy
    @post.destroy
    json_response @post
  end
  
  def update
    if @post.update(post_params)
      json_response @post
    else
      json_response @post.errors
    end
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title)
  end
end
