class ClientController < ApplicationController

  Dir[Rails.root.join('lib', 'liquid', '*.rb')].each {|file| require file }

  def themes_dir
    Rails.root.join('themes')
  end

  def file_from_name(name, theme = @config.get(:site)[:theme])
    themes_dir.join(theme, name)
  end

  def file_from_route(url)
    routes = Setting.open(themes_dir.join(@config.get(:site)[:theme], 'theme.yml')).get(:routes)

    routes[:paths].each do |route|
      if route[:path] == url
        return file_from_name(route[:file])
      end
    end

    file = file_from_name(url[1..-1])

    if File.exist?(file)
      file
    else
      file_from_name('404.html')
    end
  end

  def parse_from_name(name)
    parse(file_from_name(name).read)
  end

  def parse_from_route(url)
    parse(file_from_route(url).read)
  end

  def parse(file)
    Liquid::Template.parse(file)
  end

  def render_page(url)
    file = file_from_route(url)
    if File.basename(file) == 'theme.yml'
      render_page('404')
    elsif File.extname(file) == '.html'
      if url.end_with?('.html')
        render_page('404')
        return
      end

      vars = variables
      vars['file'] = file.to_s

      parse(file.read).render(vars)
    else
      file.read
    end
  end

  def load_page(url)
    render :text => render_page(url)
  end

  def variables(parameters = params, custom = {})
    vars = Hash.new
    vars['params'] = parameters.except(:controller, :action)
    vars['users'] = User.all
    vars.merge(custom)
  end

  def route
    page = load_page(request.env['PATH_INFO'])
  end

end