class Admin::UsersController < ApplicationController
  before_filter :authorize_admin!
  before_filter :find_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit

  end

  def destroy
    @user.destroy
    flash[:success] = t('controllers.users.destroy.success')
    redirect_to admin_users_path
  end

  def update
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
      flash[:error] = t('controllers.users.before_filter.not_found')
      redirect_to admin_users_path
    end
  end
end
