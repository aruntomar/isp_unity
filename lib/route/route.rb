# How to route answers to packets coming in over a particular provider, 
# say Provider 1, back out again over that same provider

class Route

  class << self
    
    attr_reader :commands
    
    def build_commands(isps=[])
      @commands = []
      isps.each do |isp|
        @commands << "ip route add #{isp.network} dev #{isp.interface} src #{isp.ip_address} table #{isp.name}"
        @commands << "ip route add default via #{isp.gateway} table #{isp.name}"
      end
      @commands
    end
  end

end
