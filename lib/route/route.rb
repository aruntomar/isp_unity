# How to route answers to packets coming in over a particular provider, 
# say Provider 1, back out again over that same provider

class Route

  class << self
    
    attr_reader :commands
    
    def build_commands(isps=[])
      @commands = []
      isps.each {
        |isp| commands << "ip route add #{isp.network} dev #{isp.interface} src #{isp.gateway} table #{isp.name}"
      }
    end
  end

end
