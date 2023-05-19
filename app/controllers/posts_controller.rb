class PostsController < ApplicationController

  # 新規記録作成のviewページ
  def new
    @post = Post.new
  end

# 新規記録作成
  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    post.purchase_status = false
    if post.save
      redirect_to posts_path(current_user)
    else
      render :new
    end
  end

# 記録一覧ページ
  def index

    # 日付に関するデータを収集
    @month = params[:month]
    if @month.nil?
    @month = Date.current
    else
    @month = @month.slice(0..9)
    end

    # 1ヶ月ごとのデータを収集し、Viewに表示する
    @total_posts = Post.where(user_id: current_user.id).order("created_at DESC")
    # 月ごとの投稿をまとめたハッシュであり、キーは月の最初の日時（YYYY-MM-01 00:00:00）
    @total_posts_month = @total_posts.group_by { |post| post.created_at.beginning_of_month }

    #表示する月の選択
    @selected_month = Date.parse(params[:month]) rescue Date.today.at_beginning_of_month

    #1ヶ月間に買ったものの一覧（purchase_statusがtrueのデータ）
    @posts_buy = Post.where(purchase_status: true).where(user_id: current_user.id).where(created_at: @month.in_time_zone.all_month).order("created_at DESC")

    #1ヶ月に我慢したものの一覧（purchase_statusがfalseのデータ）
    @posts_unbuy = Post.where(purchase_status: false).where(user_id: current_user.id).where(created_at: @month.in_time_zone.all_month).order("created_at DESC")

  end

  #投稿データの詳細
  def show
    @post = Post.find(params[:id])
  end

  #「買った」ボタンを押した際に「買ったもの」に振り分けられる
  def update
    post = Post.find(params[:id])

    #「purchase_status」がfalseからtrueに変更する
    post.purchase_status = true

    post.save
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
