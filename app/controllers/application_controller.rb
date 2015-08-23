class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :globals

  def globals
    @cms = Hash.new
    @cms[:name] = 'Steve CMS'
    @cms[:version] = 'v0.0.0-BETA'
    @cms[:full_name] = @cms[:name] + ' ' + @cms[:version]

    @site = HashWithIndifferentAccess.new(YAML.load(File.read(Rails.root.join('settings', 'site.yml'))))
  end
end
