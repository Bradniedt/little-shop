class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.default_users
  end

  def show
    @user = User.find(params[:id])
    if @user.role == 'merchant'
      redirect_to admin_merchant_path(@user)
    end
    @orders = @user.orders
  end

  def create

  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      flash[:success] = 'Profile Updated'
      redirect_to admin_user_path(user.id)
    else
      @user = User.find(params[:id])
      @errors = user.errors
      render :edit
    end
  end

  def upgrade
      user = User.find(params[:user_id])
      user.update(:role => 1)
      flash[:notice] = 'This user has been upgraded.'
      redirect_to admin_merchant_path(user)
  end

  def enable
      user = User.find(params[:user_id])
    if user.enabled == true
      user.update(:enabled => false)
      flash[:notice] = "#{user.name} is now disabled"
    elsif
      user.enabled == false
      user.update(:enabled => true)
      flash[:notice] = "#{user.name} is now enabled"
    end
    redirect_to admin_users_path
  end

  def edit
      @user = User.find(params[:id])
  end

  private

  def user_params
      params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
