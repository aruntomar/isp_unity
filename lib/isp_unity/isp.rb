class Isp

  attr_accessor :name, :interface, :gateway, :subnet, :network, :online, :enabled, :ip_address, :weight, :protocol, :port, :network_ip, :priority
  
  def initialize(config_isp)
    @name       = config_isp['name']
    @interface  = config_isp['interface']
    @gateway    = config_isp['gateway']
    @subnet     = config_isp['subnet']
    @network    = config_isp['network']
    @online     = config_isp["online"]
    @enabled    = config_isp['enabled']
    @ip_address = config_isp['ip_address']
    @weight     = config_isp['weight']
    @protocol   = config_isp['protocol']
    @port       = config_isp['port']
    @network_ip = config_isp['network_ip']
    @priority   = config_isp['priority']
  end

end
