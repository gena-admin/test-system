class Admin::ApplicationController < ::ApplicationController
  before_filter :authorize_admin!
end
