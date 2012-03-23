require File.expand_path('../../../spec_helper', __FILE__)

describe "Rule" do

  before(:each) { IspUnity.config }
  let(:commands) { Rule.build_commands(IspUnity.isp_config_list) }

  context "build commands" do
    it "should 3 commands" do
      commands.count.should == 3 
    end
    
    it "should return rule command for an isp" do
      commands.first.should == "ip rule add from 61.17.193.163 table tata"
    end
  end
end
