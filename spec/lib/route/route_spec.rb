require File.expand_path('../../../spec_helper', __FILE__)

describe "Route" do

  before(:each) { IspUnity.config }
  let(:commands) { Route.build_commands(IspUnity.isp_config_list) }

  context "build commands" do
    it "should six commands" do
      commands.count.should == 6
    end
    
    it "should return route command for an isp" do
      commands.first.should == 'ip route add 61.17.193.0/24 dev eth0 src 127.0.0.1 table tata'
    end

    it "should return gateway command for an isp" do
      commands.last.should == 'ip route add default via 192.168.2.1 table bsnl'
    end
  end
end
