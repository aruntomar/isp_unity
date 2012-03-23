require File.expand_path('../../../spec_helper', __FILE__)

describe "LoadBalance" do

  before(:each) { IspUnity.config }

  context "build commands" do
    before(:each) do
      isp = IspUnity.isp_config_list.first
      isp.enabled = true
      @command = LoadBalance.build_commands([isp])
    end

    it "should return load balance command as 'ip route replace default via 61.17.193.163 dev tata' if only one is enabled" do
      @command.should == "ip route replace default via 61.17.193.163 dev eth0"
    end

  end
  it "build commands should return load balance command as none if neither isps are enabled" do
    isp = IspUnity.isp_config_list.first
    @command = LoadBalance.build_commands([isp])
    @command.should == nil 
  end

  it "build commands should return command if all isps are alive" do
    @command = LoadBalance.build_commands(IspUnity.isp_config_list)
    @command.should == "ip route replace default scope global  nexthop via 61.17.193.163 dev eth0 weight 1  nexthop via 192.168.0.2 dev eth1 weight 1  nexthop via 192.168.2.1 dev wlan0 weight 1 "
  end
end
