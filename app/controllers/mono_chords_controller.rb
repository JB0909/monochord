class MonoChordsController < ApplicationController
  include MonoChordsHelper
  def home
    @users = User.all
    @user = User.find_by(:id => params[:id])
    if user_signed_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order('created_at DESC')
      #ホームでフォロー全員の投稿を表示
      @feed_items = current_user.feed
    end
    
  end

  def show
    @user = User.find_by(:id => params[:id])
    @profile = User.find(params[:id])
    if user_signed_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order('created_at DESC')
    end
    
    @times= Micropost.where(:user_id => params[:id])
    @time_sum = @times.sum(:practice_time)
    
    @chart = Micropost.where(:user_id => params[:id]).group(:practice_content).sum(:practice_time)
  end

  def help
  end

  def about
  end

  def terms
  end

  def privacy
  end

  def edit
    @user = User.find_by(:id => params[:id])
    if @user.id == current_user.id
      render "edit"
    else
      redirect_to root_url
    end
  end

  def update
    @user = User.find(params[:id])
    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        render :edit
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end  
    else
      redirect_to root_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:image, :introduction )
  end
  


end
