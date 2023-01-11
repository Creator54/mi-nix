#!/usr/bin/env fish

set value (ifconfig $argv[1] | grep X.pa|xargs|sed 's/(//g;s/)//g')
set up (echo $value |awk -F' ' {'print $12'})
set down (echo $value |awk -F' ' {'print $5'})
set up_unit (echo $value |awk -F' ' {'print $14'})
set down_unit (echo $value |awk -F' ' {'print $7'})

function usage
	switch $down_unit
		case "KiB"
			set down (math -s0 $down/1000 )
			set down_unit "KB"
		case "MiB"
			set down (math -s2 $down/1000000 )
			set down_unit "MB"
		case "GiB"
			set down (math -s3 $down/1000000000)
			set down_unit "GB"
	end

	switch $up_unit
		case "KiB"
			set up (math -s0 $up/1000 )
			set up_unit "KB"
		case "MiB"
			set up (math -s2 $up/1000000 )
			set up_unit "MB"
		case "GiB"
			set up (math -s3 $up/1000000000)
			set up_unit "GB"
	end

	printf " $up $up_unit  $down $down_unit \n"
end

usage
