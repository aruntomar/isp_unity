require File.expand_path('../../../spec_helper', __FILE__)

# rt_tables located at /etc/iproute2 dir

describe "RoutingTable(Assuming currently there are 3[tata, ttml, bsnl] service providers)" do
  def check_entry
    IspUnity.config
    count = File.open('./spec/rt_tables', 'rb') { |f| f.readlines.count }
    count.should == 3
  end

  after(:all) { File.open('./spec/rt_tables', 'w') {|file| file.truncate(0) } }

  context "#config" do
    it "should make an entry in rt tables file for each isp" do
      check_entry
    end

    it "should make no entry if there is an entry already exists of particular isp" do
      check_entry
    end
  end
end
