require 'i18n'
path = File.join([[File.expand_path(File.dirname(__FILE__)), '../..', 'config', 'locale', 'en.yml']])
I18n.load_path = [path]

module IspUnity

  $ip_cluster = []
  class << self

    attr_reader :isp_config_list

    def config
      # If file is exists then it reads that otherwise log an error 
      if File.exist?(ConfigFilePath)
        begin
          configurations = JSON.parse(File.read(ConfigFilePath))   
          IspUnityLog.info(I18n.t('file.read.success'))
        rescue Exception => e
          IspUnityLog.debug("#{e}")
          IspUnityLog.error(I18n.t('file.read.error'))
          raise IspUnityException.new(I18n.t('file.read.error'))
        end

        @isp_config_list = [] 
        isp_list = configurations['isp']
        $ip_cluster = configurations['public_dns']

        if isp_list 
          isp_list.each do|data|
            if data['enabled'] == 'true'
              ip_addr = SystemCall.get_ip(data['interface'].to_s)
              if ip_addr
                data['ip_address'] = SystemCall.get_ip(data['interface'])
                @isp_config_list.push(Isp.new(data)) 
              else
                puts I18n.t('no_ip_addr') + data['name']
                IspUnityLog.error(I18n.t('no_ip_addr') + data['name'] )
              end
            end
          end
          IspUnityLog.info('Isp Object succesfully created!')
        else
          raise IspUnityException.new(I18n.t('file.enter_isp'))
          IspUnityLog.error(I18n.t('file.read.no_isp_found'))
        end


        routing_table = File.read(RoutingTablePath)
        IspUnityLog.info(I18n.t('routing_table.read.success'))
        begin
          @isp_config_list.each do|isp_list|
            unless routing_table.include?(isp_list.name)
              File.open(RoutingTablePath, 'a') {|f| f.write("#{rand(100)}  #{isp_list.name} \n")}
            end
            IspUnityLog.info(I18n.t('isp.created'))
          end
        rescue Exception => e
          IspUnityLog.debug("#{e}")
          IspUnityLog.error(I18n.t('routing_table.read.error'))
          raise IspUnityException.new(I18n.t('routing_table.read.error'))
        end
      else
        @isp_config_list = []
        puts "Please make ensure that configuration file has copied on /etc dir"
        IspUnityLog.error('Please make ensure that configuration file has copied on /etc dir')
      end
    end
  end
end
