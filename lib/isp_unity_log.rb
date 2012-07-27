# Log file :-
# Creating logger for IspUnity, setting default if unable to read configurations.
# We are reading config file and setting log level mentioned in it

include Log4r

IspUnityLog = Logger.new("log")
filename = "ispunity.log"
pf = PatternFormatter.new(:pattern => "%d %l %m")
IspUnityLog.level = 0

# Cuurenlty we are saving log information under /var
# TODO: Update when making changes so that user can run this without root access
IspUnityLog.outputters = FileOutputter.new("IspUnity", :filename => File.join("/var","log",filename), :formatter => pf)

if ConfigFilePath && File.exist?(ConfigFilePath)
  begin
    configurations = JSON.parse(File.read(ConfigFilePath))  
    LOG_LEVEL = configurations['log_level']
    IspUnityLog.info(I18n.t('log_level.success'))
  rescue Exception => e
    IspUnityLog.debug("#{e}")
    IspUnityLog.error(I18n.t('file.read.error'))
    raise IspUnityException.new(I18n.t('log_level.error'))
  end
end

IspUnityLog.level = LOG_LEVEL.nil? ? 0 : LOG_LEVEL
