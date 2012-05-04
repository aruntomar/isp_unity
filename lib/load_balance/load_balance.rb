class LoadBalance

  class << self
    attr_reader :commands

    def build_commands(isps)
      @commands = []
      alive_isps = []
      isps.each do |isp|
	 if is_alive(isp) 
	   alive_isps << isp 
           IspUnityLog.info("#{isp.name} is online")
	 else
           IspUnityLog.info("#{isp.name} is offline")
	 end
      end
      if alive_isps.size == 1
        IspUnityLog.info("Only 1 isp is alive")
        @commands << "/sbin/ip route replace default via #{alive_isps[0].gateway} dev #{alive_isps[0].interface}" 
      else
        IspUnityLog.info("Multiple isps are alive")
        @commands << "/sbin/ip route replace equalize default "
        alive_isps.each do |isp|
          @commands[0] += " nexthop via #{isp.gateway} dev #{isp.interface} weight #{isp.weight} "  
        end
      end
      return @commands[0]
    end

    def is_alive(isp)
      return true if ENV['GEM_ENV']=='test'
      return false unless isp.enabled == 'true'
      result = `/bin/ping -c 3 -I #{isp.ip_address} #{$ip_cluster.sample}`
      if result.match("100% packet loss")
           IspUnityLog.info("100% packet loss for #{isp.name}")
           isp.online = false
      else
          IspUnityLog.info("0% packet loss for #{isp.name}")
          isp.online = true
      end
      return isp.online 
    end

  end

end
