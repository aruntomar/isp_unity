require File.expand_path('../../../spec_helper', __FILE__)

# rt_tables located at /etc/iproute2 dir

describe "RoutingTable(Assuming currently there are 3[tata, ttml, bsnl] service providers)" do
  context "#config" do
    it "should build isp object of type json"
    it "should build isp object of size three"
    it "should raise an exception of type 'file not found' if there is no config file"
    it "should make an entry in rt tables file for each isp"
    it "should make no entry if there is an entry already exists of particular isp"
  end
end
