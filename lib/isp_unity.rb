require 'json'
require 'yaml'
require 'lib/isp_unity_log'
require 'lib/route/route'
require 'lib/system_call'
require 'lib/rule/rule'
require 'lib/isp_unity/isp'
require 'lib/isp_unity/version'
require 'lib/isp_unity/routing_table'


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
end
