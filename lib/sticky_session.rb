class StickySession 
  
  class << self

    def execute(isps=[])
      isps.each do |isp|
        if isp.skip_sticky_session
          # Mark the outgoing packet with port value
          command = "iptables -t mangle -A PREROUTING -s #{isp.network_ip} -p #{isp.protocol} --dport #{isp.dport} -j MARK --set-mark #{isp.dport}"
          SystemCall.execute(command)
          # Lookup the ISP depends on marked value 
          command = "ip rule add fwmark #{isp.port} lookup #{isp.name}"
          SystemCall.execute(command)
        end
      end
    end

    def change_rule(offline_isps=[], online_isps=[])
      #online_isps consist of online isps
      online_isps.sort! { |a,b| a.priority  <=> b.priority }
    
     # Remove rule of failed(offline) isp
      offline_isps.each do |isp|
        if isp.skip_sticky_session
          command = "ip rule del fwmark #{isp.port} lookup #{isp.name}"
        end
      end

      # Add new rule to online isp with high priority
      offline_isps.each do |isp|
        if isp.skip_sticky_session
          command = "ip rule add fwmark #{isp.port} lookup #{online_isps[0].name}"
        end
      end

    end

  end
end
