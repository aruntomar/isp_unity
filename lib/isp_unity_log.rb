$LOAD_PATH <<  File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'log4r'
 
include Log4r

filename = "ispunity.log"
 
IspUnityLog = Logger.new("log")
IspUnityLog.level = DEBUG
pf = PatternFormatter.new(:pattern => "%d %l %m")
IspUnityLog.outputters = FileOutputter.new("IspUnity", :filename => File.join(File.dirname(__FILE__),"..","log",filename), :formatter => pf)
 
