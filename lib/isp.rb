class ISP

  attr_accessor :id, :name, :interface, :gateway, :subnet, :network, :online, :enabled
  
  def initialize(config_isp = {})
    @id = config_isp['id']
    @name = config_isp['name']
    @interface = config_isp['interface']
    @gateway = config_isp['gateway']
    @subnet = config_isp['subnet']
    @network = config_isp['network']
    @online = config_isp["online"]
    @enabled = config_isp['enabled']
  end
  

end
