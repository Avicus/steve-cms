class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :globals

  require 'setting'

  def globals
    @cms = Hash.new
    @cms[:name] = 'Steve CMS'
    @cms[:version] = 'v0.0.0-BETA'
    @cms[:full_name] = @cms[:name] + ' ' + @cms[:version]

    @config = Setting.main
  end

  def current_user
    User.find_by_id(cookies.signed[:user_id])
  end

  def current_user?
    current_user != nil
  end
end
