class SystemCall
  class << self
    def execute(commands=[])
      begin
        commands.each {|cmd| `#{cmd}`} 
        return true
      rescue Exception => e
        IspUnityLog.debug("#{e}")
        IspUnityLog.error(I18n.t('system_call.execute.error'))
        IspUnityException.new(I18n.t('system_call.execute.error'))
      end
    end

    def get_ip(interface)
      begin
        result = `'/sbin/ifconfig' #{interface}`
        ip = /\inet addr:(?<ip>(\d+[.]){3}\d+)/.match(result)
        ip = ip[0].split(':')[1] if ip
      rescue Exception => e
        IspUnityLog.debug("#{e}")
        IspUnityLog.error(I18n.t('system_call.execute.error'))
        IspUnityException.new(I18n.t('system_call.execute.error'))
      end
    end
  end
end
