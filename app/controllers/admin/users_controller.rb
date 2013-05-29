class Admin::UsersController < ApplicationController
  before_filter :authorize_admin!
  before_filter :find_user, :only => [:edit, :destroy]

  def index
    @users = User.all
  end

  def edit

  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    @user.is_admin = params[:is_admin]
    if @user.save
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:error] = "User not found!"
      redirect_to admin_users_path
    end
  end
end
