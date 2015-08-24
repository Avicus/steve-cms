class Setting
  def self.main
    Setting.new(Rails.root.join('settings', 'main.yml'))
  end

  def self.open(path)
    Setting.new(Rails.root.join(path))
  end

  attr_accessor :config, :path

  def initialize(path)
    @path = path
    @config = HashWithIndifferentAccess.new(YAML.load(File.read(path)))
  end

  def get(key, default = nil)
    @config[key] || default
  end

  def set(key, value, saveAfter = true)
    @config[key] = value
    save
  end

  def save(path = self.path)
    File.open(path, 'w') {|f| f.write config.to_yaml }
  end
end