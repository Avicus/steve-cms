class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :globals

  def globals
    @cms = Hash.new
    @cms[:name] = 'Steve CMS'
    @cms[:version] = 'v0.0.0-BETA'
    @cms[:full_name] = @cms[:name] + ' ' + @cms[:version]

    @site = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join('settings', 'site.yml'))))

    @config = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join('settings', 'config.yml'))))
  end

  def current_user
    User.find_by_id(cookies.signed[:user_id])
  end

  def current_user?
    current_user != nil
  end
end
