class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.purchase_status = false
    @post.save
    redirect_to posts_path(current_user)
  end

  def index
    @posts_buy = Post.where(purchase_status: true).where(user_id: current_user.id).order("created_at DESC")
    # puts "ここを見ろ"
    # p @posts_buy
    @posts_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id).order("created_at DESC")
    # p @posts_unbuy
    # p @posts

  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    puts "ここを見ろ"
    # p params
    # puts params[:id]
    @post = Post.find(params[:id])
    p @post
    @post.purchase_status = true
    @post.save
    redirect_to posts_path
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:price, :category, :product, :comment)
  end

end
