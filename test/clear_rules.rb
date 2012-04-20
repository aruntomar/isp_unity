table_names = %w{tata bsnl ttml}

table_names.each do |t|
	`ip rule list|grep -i "#{t}"|wc -l`.chomp.to_i.times {`ip rule del table "#{t}"; ip route flush table "#{t}"`}
end
