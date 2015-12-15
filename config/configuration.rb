module CallShibe
  class Configuration < ::Settingslogic

    source File.expand_path File.join(
                              ::CallShibe.root,
                              'config',
                              'call_shibe.yml')

    namespace CallShibe.environment.to_s
  end
end
