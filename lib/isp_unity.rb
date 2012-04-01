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

  config_file = File.join([File.expand_path(File.dirname(__FILE__)), '..', 'config', 'settings.yml'])
  ENV['GEM_ENV'] ||= 'development'
  PATH = YAML.load_file( config_file )[ENV['GEM_ENV']]['ubuntu']
  ConfigFilePath =  File.join([File.expand_path(File.dirname(__FILE__)), '..',PATH['config_file_path']])
  RoutingTablePath = PATH['rt_table_path'].to_s

  class IspUnityException < Exception
    def initialize(message)
      message = message['error'] if message.class == Hash
      super "[IspUnity] #{message}"
    end
  end

  class << self

    def setup
      IspUnity.config
      IspUnityLog.info(I18n.t('file.write'))
      Route.build_commands(IspUnity.isp_config_list)
      IspUnityLog.info(I18n.t('route.build_commands'))
      if SystemCall.execute(Route.commands)
        IspUnityLog.info(I18n.t('system_call.execute.route.success'))
        Rule.build_commands(IspUnity.isp_config_list)
        IspUnityLog.info(I18n.t('rule.build_commands'))
        SystemCall.execute(Rule.commands)
        IspUnityLog.info(I18n.t('system_call.execute.rule.success'))
        LoadBalance.build_commands(IspUnity.isp_config_list)
        IspUnityLog.info(I18n.t('load_balance.build_commands'))
        SystemCall.execute(LoadBalance.commands)
        IspUnityLog.info(I18n.t('system_call.execute.load_balance.success'))
      end
    end

    def monitor
      IspUnity.isp_config_list.each do |isp|
        new_list << isp  if LoadBalance.is_alive(isp) 
      end
      unless  new_list == isp_config_list
        LoadBalance.build_commands(IspUnity.isp_config_list)
        IspUnityLog.info(I18n.t('load_balance.build_commands'))
        SystemCall.execute(LoadBalance.commands)
        IspUnityLog.info(I18n.t('system_call.execute.load_balance.success'))
        SystemCall.execute('ip route flush cache')
      end

    end
  end

end

