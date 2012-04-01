class Rule
  
  class << self

    attr_reader :commands
    
    def build_commands(isps=[])
      @commands = []
      isps.each do |isp|
        output = `ip rule show`
        @commands << "ip rule add from #{isp.gateway} table #{isp.name}" if output.include?(isp.name)
      end
      @commands
    end
  end
end
