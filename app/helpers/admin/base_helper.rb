module Admin::BaseHelper
  def nav_link(path, options, &block)
    if current_page?(path)
      options[:class] = '' unless options.include?(:class)
      options[:class] += ' active'
    end
    link_to path, options, &block
  end
end
