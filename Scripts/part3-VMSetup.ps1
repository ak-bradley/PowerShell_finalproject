# create log path
$logpath = "c:\itlab\vmlogs\vm-creation.log"

# create vm with existing os vhd and log activity
new-vm -name "WindowsServer" -memorystartupbytes 2gb -vhdpath "c:\users\iana\documents\20348.169.amd64fre.fe_release_svc_refresh.210806-2348_server_serverdatacentereval_en-us.vhd" -generation 1

add-content -path $logpath -value "VM WindowsServer created at $(get-date)"

# enable outbound connectivity via host's NAT-based virtual switch and log activity
add-vmnetworkadapter -vmname "windowsserver" -switchname "default switch"

add-content -path $logpath -value "Connection established at $(get-date)"

#confirm if it works and pipe status data to a separate file
get-vm -name "windowsserver" | tee-object -filepath "c:\itlab\vmlogs\vm-status.txt"

# let it run and log
start-vm -name "WindowsServer"
add-content -path $logpath -value "WindowsServer setup successful. VM up and running"

# log memory info into the file
get-vmmemory -vmname "windowsserver" | out-file "c:\itlab\vmlogs\vm-memory.txt"

