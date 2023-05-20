class UsersController < ApplicationController
  #ユーザー一覧ページ
  def index
    #ページングを使用し、10人ずつ表示される
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])

    #月の最初と終わりの定義
    @start_date = Date.current.beginning_of_month
    @end_date = @start_date.end_of_month

    #1ヶ月の間に投稿された「買ったもの」と「我慢したもの」を収集
    @posts_buy = Post.where(purchase_status: true).where(user_id: current_user.id).order("created_at DESC").where(created_at: @start_date..@end_date)
    @posts_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id).order("created_at DESC").where(created_at: @start_date..@end_date)

    #収集されたそれぞれのデータの合計金額
    @total_buy = @posts_buy.sum(:price)
    @total_unbuy = @posts_unbuy.sum(:price)

    #そのユーザーの持つ過去の我慢額の総額の表示
    @user_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id)
    @all_unbuy = @user_unbuy.sum(:price)

    #ユーザーが目標金額を設定していた場合、達成率を表示
    if @user.goal_money.present?
      
      @goal_money = @user.goal_money
      # 小数第二位まで計算(to_fメソッドで数値を浮動小数点数にし、roundメソッドで小数第二位まで計算している)
      @completion_rate = (@total_unbuy.to_f / @user.goal_money).round(2)

    #設定していない場合、０を表示
    else
      @goal_money = 0
      @completion_rate = 0

    end

    #簡易的なユーザー一覧の表示
    @users = User.page(params[:page]).reverse_order
    @users.each do |user|
      #それぞれのユーザーの過去の我慢額を表示
      posts_unbuy = user.posts.where(purchase_status: false)
      total_unbuy = posts_unbuy.sum(:price)
      user.total_unbuy = total_unbuy
    end

  end

  #ユーザー情報の編集ページ
  def edit
    @user = User.find(params[:id])
  end

  #ユーザー情報の更新
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
