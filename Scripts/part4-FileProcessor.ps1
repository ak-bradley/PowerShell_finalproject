# create a path to the already existing folder and path to summary file
$folderpath = "c:\itlab\userdata"
$summary = "c:\itlab\documentation\user-summary.txt"

# create 10 users
$users = @("user1", "user2", "user3", "user4", "user5", "user6", "user7", "user8", "user9", "user10")

# create an empty array of processed files
$processedfiles = @()

# create 10 files pertaining to each user with individual information
foreach ($user in $users){
$filepath = join-path -path $folderpath -childpath "$user.txt"    # create a file path

$content = "Name: $user 
Mail: $user@itlab.com
Function: New Associate"

$content | out-file $filepath      # extract content into the file

$processedfiles += $filepath}     # append the array with total value of the files created

# write processed files into the summary file
$processedfiles | out-file -filepath $summary

# display file count on console
write-host "Number of files processed: $($processedfiles.count)"

