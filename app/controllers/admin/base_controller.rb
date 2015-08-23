class Admin::BaseController < ApplicationController

  layout 'admin/main'

  before_filter :check_admin

  def check_admin
    render :text => current_user.to_json
    return
  end

end