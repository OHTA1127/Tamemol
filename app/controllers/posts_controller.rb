class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.purchase_status = false
    if @post.save
      redirect_to posts_path(current_user)
    else
      render :new
    end
  end

  def index
    @latest_month = Post.order(created_at: :desc).first.created_at.strftime('%Y年%m月')
    @posts_buy = Post.where(purchase_status: true).where(user_id: current_user.id).order("created_at DESC")
    # puts "ここを見ろ"
    # p @posts_buy
    @posts_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id).order("created_at DESC")
    # p @posts
    @posts_buy_month = @posts_buy.group_by { |post| post.created_at.beginning_of_month }
    @posts_unbuy_month = @posts_unbuy.group_by { |post| post.created_at.beginning_of_month}
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
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:price, :category, :product, :comment)
  end

end
