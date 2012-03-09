class Rule
  class << self

    attr_reader :commands

    def build_commands(isps=[])
      @commands = []
      isps.each do |isp|
        commands << "ip rule add from #{isp.gateway} table #{isp.name}"
      end
    end
  end
end
