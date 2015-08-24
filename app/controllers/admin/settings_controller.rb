class Admin::SettingsController < Admin::BaseController

  def index
    if request.post?
      category = params[:category]
      result = false
      if category == 'site'
        result = settings_site
      end
    end
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