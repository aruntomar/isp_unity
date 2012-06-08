$LOAD_PATH <<  File.expand_path(File.dirname(__FILE__))
require 'json'
require 'yaml'
require 'isp_unity_log'
require 'sticky_session'
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
  ConfigFilePath =  File.join(PATH['config_file_path'])
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
      isp_lists = IspUnity.isp_config_list
      IspUnityLog.info(I18n.t('file.write'))
      Route.build_commands(isp_lists)
      route_command = Route.commands
      IspUnityLog.info(I18n.t('route.build_commands'))
      IspUnityLog.debug("Route Command: #{route_command}")
      if SystemCall.execute(route_command)
        IspUnityLog.info(I18n.t('system_call.execute.route.success'))

        #RULE COMMAND
        Rule.build_commands(isp_lists)
        rule_command = Rule.commands
        IspUnityLog.info(I18n.t('rule.build_commands'))
        IspUnityLog.debug("Rule Command: #{rule_command}")
        SystemCall.execute(rule_command)
        IspUnityLog.info(I18n.t('system_call.execute.rule.success'))

        #LOAD BALANCE
        LoadBalance.build_commands(isp_lists)
        load_balance_command = LoadBalance.commands
        IspUnityLog.info(I18n.t('load_balance.build_commands'))
        IspUnityLog.debug("Load Balance Command: #{load_balance_command}")
        SystemCall.execute(load_balance_command)
        IspUnityLog.info(I18n.t('system_call.execute.load_balance.success'))

        #Sticky Session
        StickySession.execute(isp_lists) unless $skip_sticky_session
      end
    end

    def monitor
      IspUnity.config
      online_isps = []
      IspUnity.isp_config_list.each do |isp|
        online_isps << isp  if LoadBalance.is_alive(isp) 
      end

      #Failover case
      unless  online_isps == isp_config_list

        #LOAD BALANCE
        LoadBalance.build_commands(IspUnity.isp_config_list)
        IspUnityLog.info(I18n.t('load_balance.build_commands'))
        SystemCall.execute(LoadBalance.commands)
        IspUnityLog.info(I18n.t('system_call.execute.load_balance.success'))

        #Flush route
        SystemCall.execute('/sbin/ip route flush cache')

        #Change sticky session 
        offline_isps = isp_lists - online_isps
        StickySession.change_rule(offline_isps, online_isps)
  
      end
    end
  end
end

