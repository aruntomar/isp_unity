# How to route answers to packets coming in over a particular provider, 
# say Provider 1, back out again over that same provider

class Route

  def build_command(isps=[])
    execute {isps.each {
      |isp| system("ip route add #{isp[:network]} dev #{isp[:interface]} src #{isp[:gateway]} table #{isp[:name]}")
    }}
  end

  private 

  def execute(&block)
    SystemCall.new.execute &block
  end
end
