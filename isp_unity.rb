#TODO Change File name convention
#TODO Error handling 
#TODO Logging
#TODO check the configuration file based on os specific 


require 'json'
require './lib/isp'
require './lib/mylib'

class IspUnity
  
  configfile = 'config/sample.json'
  json = File.read(configfile)
  $parse_data = JSON.parse(json)   
  
  attr_reader :isp_config_list, :no_of_isp

  def initialize
    @no_of_isp = $parse_data["no_of_isp"]
    @interval = $parse_data["interval"]
  end

  def create_isp
    isp_list = $parse_data["isp"]
    @isp_config_list = [] 
    if @no_of_isp
        isp_list.each do|data|
          @isp_config_list.push(ISP.new(data))
        end
    end
    
  end
  
end

main = IspUnity.new

main.create_isp
check_or_insert_rt_table(main.isp_config_list)
#
