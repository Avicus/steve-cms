class Admin::BaseController < ApplicationController

  layout 'admin/main'

  before_filter :check_admin

  def check_admin
    unless current_user?
      # return if redirect_to(login_path, :flash => {:error => 'You must login to access that part of the website.'})
    end
  end

end