class Partial < Liquid::Tag
  def initialize(tag_name, name, tokens)
     super
     @name = name
  end

  def render(context)
    file = Pathname.new(context.environments.first['file']).join('..', @name)
    parsed = ClientController.new.parse_from_name(file)
    vars = ClientController.new.variables({}, {:file => file})
    parsed.render(vars)
  end
end

Liquid::Template.register_tag('partial', Partial)