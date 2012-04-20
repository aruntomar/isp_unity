class LoadBalance

  class << self
    attr_reader :commands

    def build_commands(isps)
      @commands = []
      alive_isps = []
      isps.each do |isp|
	 alive_isps << isp if is_alive(isp) 
      end
      if alive_isps.size == 1
        @commands << "/sbin/ip route replace default via #{alive_isps[0].gateway} dev #{alive_isps[0].interface}" 
      else
        @commands << "/sbin/ip route replace default scope global "
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
          return false
      else
          return true
      end
    end

  end

end
