# create a log file
$logfile = "c:\itlab\documentation\system-report.txt"

# create a variable for computername
$cname = $env:computername 

# create a variable for username
$uname = $env:username 

# provide current date
$date = get-date

# provide current version info
$sysinfo = (get-ciminstance win32_operatingsystem).caption 

# provide intel on available disk space on c
$disk = get-volume -driveletter c
$freespace = $disk.sizeremaining/1gb

# type "Summary" on the screen only 
write-host "SUMMARY"

# build a summary of the requested items and print the summary on the screen and write to the file simultaneously

$print= @"
USER: $uname
COMPUTER: $cname
DATE: $date
WINDOWS VERSION: $sysinfo
FREE SPACE C: $freespace GB
"@

$print | tee-object -filepath $logfile -append

# names of running services appended only to the file
get-service | select-object -expandproperty name | out-file -filepath $logfile -append

# create a function printing critical service stat updates both in terminal and in the log file

function log-status{
param ( [string]$msg)

# write to terminal
write-host $msg

# append stat to log file
"$msg at $(get-date)" | add-content -path $logfile}

# get stat updates and messages on chosen services
$spoolstat = get-service -name "spooler"
if ($spoolstat.status -eq "stopped") {log-status "Warning! Spooler is stopped!"}
else {log-status "Spool stat check OK. Service running"}

$dhcpstat = get-service -name "dhcp"
if ($dhcpstat.status -eq "stopped") {log-status "Warning! DHCP is stopped!"}
else {log-status "DHCP stat check OK! Service running"}

$dnsstat = get-service -name "dnscache"
if ($dnsstat.status -eq "stopped") {log-status "Warning! DNS is stopped!"}
else {log-status "DNS stat check OK! Service Running"}


