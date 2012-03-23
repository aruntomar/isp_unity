class LoadBalance

  class << self

    attr_reader :commands

    def build_commands(isps)
      @commands = []
      if isps.count == 1
        @commands << "ip route replace default via #{isps[0].gateway} dev #{isps[0].interface}" if isps[0].enabled
      else
        @commands << "ip route replace default scope global "
        isps.each do |isp|
          @commands[0] += " nexthop via #{isp.gateway} dev #{isp.interface} weight #{isp.weight} "  if LoadBalance.is_alive(isp) 
          #puts @commands
        end
      end
      return @commands[0]
    end

    def is_alive(isp)
      return false unless isp.enabled == 'true'
      result = `"/bin/ping -c 3 -I #{isp.ip_address} #{$ip_cluster.sample}"`
      if result.match("100% packet loss")
          return false
      else
          return true
      end
    end

  end

end
