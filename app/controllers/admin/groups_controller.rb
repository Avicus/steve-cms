class Admin::GroupsController < Admin::BaseController

  def index

  end

  private

  def settings_site
    input = params.permit(:name, :tagline, :time_zone, :date_format, :time_format, :language)

    @site = @config.get(:site)
    @site = @site.merge(input)

    @config.set(:site, @site)

    'Site settings saved successfully (that alliteration.)!'
  end

end