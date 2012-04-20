class Rule
  
  class << self

    attr_reader :commands
    
    def build_commands(isps=[])
      @commands = []
      isps.each do |isp|
        output = `/sbin/ip rule show`
        @commands << "/sbin/ip rule add from #{isp.gateway} table #{isp.name}" unless output.include?(isp.name)
      end
      @commands
    end
  end
end
