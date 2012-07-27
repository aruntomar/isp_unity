# Init, we are reading settings, loading config files here

config_file = File.join([File.expand_path(File.dirname(__FILE__)), '..', 'config', 'settings.yml'])
ENV['GEM_ENV'] ||= 'development'
PATH = YAML.load_file( config_file )[ENV['GEM_ENV']]['ubuntu']
ConfigFilePath =  File.join(PATH['config_file_path'])
RoutingTablePath = PATH['rt_table_path'].to_s

class IspUnityException < Exception
  def initialize(message)
    message = message['error'] if message.class == Hash
    super "[IspUnity] #{message}"
  end
end
