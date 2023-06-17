class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @vtubers= Vtuber.page(params[:page]).per(8)
    @vtubers = Vtuber.where(status: true).order("created_at DESC").page(params[:page]).per(8)
    # @vtubers = @user.vtubers
    # @vtuber = Vtuber.new
  end

  def confirm
    @user = User.find(params[:id])
    @vtubers = @user.vtubers.where(status: false).order('created_at DESC').page(params[:page]).per(20)
    @vtuber = Vtuber.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def favorites
    @favorite_vtubers = current_user.favorite_vtubers
    @vtuber = @favorite_vtubers.first
  end

  private

  def set_user
    @user =User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
