module IspUnity

  class << self

    attr_reader :isp_config_list

    def config
      begin
        configurations = JSON.parse(File.read(ConfigFilePath))   
      rescue 
         raise IspUnityException.new('Configuration file is corrupted!!!')
      end
      
      @isp_config_list = [] 
      no_of_isp = configurations['no_of_isp']
      isp_list = configurations['isp']

      if no_of_isp
        isp_list.each do|data|
          @isp_config_list.push(Isp.new(data))
        end
      else
         raise IspUnityException.new('Please enter configuration of ISP')
      end

      #TODO Remove isp name which are present in rt_table but not in new isp_list
      #TODO RnD about the number assigned to each isp
      routing_table = File.read(RoutingTablePath)
      @isp_config_list.each do|isp_list|
        unless routing_table.include?(isp_list.name)
          File.open(RoutingTablePath, 'a') {|f| f.write("#{rand(100)}  #{isp_list.name} \n")}
        end
      end

    end
  end
end
