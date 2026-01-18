# establish a path for the main folder
$mainfolder = "C:\ITLab" 

# create the main folder 
mkdir $mainfolder 

# create log file
$logfile = "log-setup.txt"

# create a path for the log file 
$logpath = new-item $mainfolder\$logfile -type file

# create log msg 1
add-content -path $logpath -value "ITLab file created at $(get-date)"

# create subfolder list 
$subfolders = @("Scripts", "Documentation", "UserData", "Backups", "VMLogs") 

# create subfolders inside the main folder 
$subfolders | foreach-object { mkdir "$mainfolder\$_" } 

# create log msg 2
add-content -path $logpath -value "Subfolders created at $(get-date)"

# set admin permissions for scripts folder along with inheritence extension
icacls "$mainfolder\scripts" /grant "administrators:(oi)(ci)f" /grant "users:(oi)(ci)r" 

# create log msg 3
add-content -path $logpath -value "Scripts folder privileges modified: Admins F Users R at $(get-date)"

# create the welcome file 
$welcome = "welcome.txt" 

# loop through each subfolder 
foreach ($subfolder in $subfolders) { 

# 1. build the path to the subfolder 
$joinfolder = join-path -path $mainfolder -childpath $subfolder 

# 2. create the welcome file in each of the subfolders 
$msgpath = join-path -path $joinfolder -childpath $welcome 
new-item -path $msgpath -itemtype file 

# 3. assign a custom message to a variable in each folder 
$msg = switch ($subfolder) { 
    "Scripts" { "Welcome to Scripts folder. Place your scripts here." } 
    "Documentation" { "Welcome to Documentation folder. Place all important documents here." } 
    "UserData" { "Welcome to User Data folder. Here is the information regarding user accounts." } 
    "Backups" { "Welcome to Backups folder to safely store projects." } 
    "VMLogs" { "Welcome to VMLogs folder to store your virtual machine logs." }} 

# 4. set the welcome message and apply to each folder
set-content -path $msgpath -value $msg}

# create log msg 4 & 5

add-content -path $logpath -value "Custom message added to each subfolder at $(get-date)"
add-content -path $logpath -value "Setup successful! $(get-date)"





