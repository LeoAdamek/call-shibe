require 'yaml'

module CallShibe
  def self.config_file
    ENV['SHIBE_CONFIG_FILE'] || File.join(root , 'config/call_shibe.yml')
  end

  def self.config
    YAML.load_file(config_file)[environment]
  end
end
