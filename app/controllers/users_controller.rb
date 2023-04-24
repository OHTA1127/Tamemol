class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    
    @start_date = Date.current.beginning_of_month
    @end_date = @start_date.end_of_month

    @posts_buy = Post.where(purchase_status: true).where(user_id: current_user.id).order("created_at DESC").where(created_at: @start_date..@end_date)
    @posts_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id).order("created_at DESC").where(created_at: @start_date..@end_date)

    @total_buy = @posts_buy.sum(:price)
    @total_unbuy = @posts_unbuy.sum(:price)

    @goal_money = @user.goal_money
    @completion_rate = (@total_unbuy.to_f / @user.goal_money).round(2)
    
    @users = User.all
    @users.each do |user|
      posts_unbuy = user.posts.where(purchase_status: false)
      total_unbuy = posts_unbuy.sum(:price)
      user.total_unbuy = total_unbuy
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User. find(params[:id])
    user .update(user_params)
    redirect_to user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :goal_comment, :goal_money)
  end

end
