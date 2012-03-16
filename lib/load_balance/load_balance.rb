class LoadBalance

  class << self
    
    attr_reader :commands

    def build_commands(isps)
      @commands = []
      if isps.count == 1
        commands << "ip route add default via #{isps[0].gateway} dev #{isps[0].interface}"
      else
        commands << "ip route add default scope global "
        isps.each do |isp|
          commands[0] += " nexthop via #{isp.gateway} dev #{isp.interface} weight #{isp.weight} "
        end
      end
    end
  end

end
