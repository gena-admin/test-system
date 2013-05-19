class GroupsController < ApplicationController
  before_filter :authorize_user!
  before_filter :find_group, :only => %w(show edit update destroy)

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create params[:group]
    @group.save ? redirect_to(groups_path) : render(:action => 'new')
  end

  def show
    @group.includes(:questions)
  end

  def edit
  end

  def update
    @group.update_attributes params[:group]
    @group.save ? redirect_to(groups_path) : render(:action => 'edit')
  end

  def destroy
    @group.destroy
    if @group.destroyed?
      flash[:notice] = 'Group is successfully deleted'
    else
      flash[:error] = 'Group can\'t be destroyed'
    end
    redirect_to groups_path
  end

  private

  def authorize_user!
    redirect_to root_path, :flash => { :error => 'You have no permissions'} unless current_user.admin?
  end

  def find_group
    @group = Group.find_by_id params[:id]
    redirect_to groups_path, :flash => { :error => 'Group not found' } if @group.nil?
  end
end
