class SystemCall
  class << self
    def execute(commands=[])
      begin
        commands.each {|cmd| system(cmd)} 
        return true
      rescue Exception => e
        IspUnityLog.debug("#{e}")
        IspUnityLog.error(I18n.t('system_call.execute.error'))
        raise IspUnityException.new(I18n.t('system_call.execute.error'))
      end
    end
  end
end
