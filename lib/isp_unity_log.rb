$LOAD_PATH <<  File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'log4r'
 
include Log4r
 
IspUnityLog = Logger.new("log")
pf = PatternFormatter.new(:pattern => "%d %l %m")
IspUnityLog.outputters = FileOutputter.new("IspUnity", :filename => "log/isp_unity.log", :formatter => pf)
 
