require 'yaml'

module CallShibe
  def self.config_file
    ENV['SHIBE_CONFIG_FILE'] || File.join(self.root , 'config/call_shibe.yml')
  end

  def self.config
    YAML.load_file(self.config_file)[self.environment]
  end
end
