$LOAD_PATH <<  File.expand_path(File.dirname(__FILE__))
require 'lib/isp_unity'
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
puts SystemCall.execute(LoadBalance.build_commands(IspUnity.config))
