require 'json'
require 'lib/isp_unity_log'
require 'lib/isp_unity/isp'
require 'lib/isp_unity/version'
require 'lib/isp_unity/routing_table'


module IspUnity
  
  ConfigFilePath = './config/sample.json'
  RoutingTablePath = '/etc/iproute2/rt_tables'

  class IspUnityException < Exception
    def initialize(message)
      message = message['error'] if message.class == Hash
      super "[IspUnity] #{message}"
    end
  end

end
