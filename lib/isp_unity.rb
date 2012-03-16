$LOAD_PATH <<  File.expand_path(File.dirname(__FILE__))
require 'json'
require 'yaml'
require 'isp_unity_log'
require 'route/route'
require 'load_balance/load_balance'
require 'system_call'
require 'rule/rule'
require 'isp_unity/isp'
require 'isp_unity/version'
require 'isp_unity/routing_table'


module IspUnity

  config_file = File.join(Dir.pwd, 'config', 'settings.yml')
  ENV['GEM_ENV'] ||= 'development'
  PATH = YAML.load_file( config_file )[ENV['GEM_ENV']]['ubuntu']
  ConfigFilePath = PATH['config_file_path'].to_s
  RoutingTablePath = PATH['rt_table_path'].to_s

  class IspUnityException < Exception
    def initialize(message)
      message = message['error'] if message.class == Hash
      super "[IspUnity] #{message}"
    end
  end

end

