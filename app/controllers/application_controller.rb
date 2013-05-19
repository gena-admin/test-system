class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  protected

  def authorize_admin!
    render_access_denied unless current_user.admin?
  end

  def render_access_denied
    render :file => "#{Rails.root}/public/401", :layout => false, :status => 401
  end
end
