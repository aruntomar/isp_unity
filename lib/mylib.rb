
def run_custom_command(cmd)


end


#
def check_or_insert_rt_table(isp_config_list)
  #rt_table = File.new("/etc/iproute2/rt_tables") 
  
  isp_config_list.each do|isp_list|
    File.open("/etc/iproute2/rt_tables", 'a') {|f| f.write("#{rand(100)}  #{isp_list.name} \n")}
  end

end
