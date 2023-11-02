#cat Get-Content  echo Write-Output
$HOSTS = Get-Content C:\Windows\System32\drivers\etc\hosts | grep -v "^#" | grep -v "127" | awk '{print $2}';
$LOCAL_STORAGE_DIR=$(wsl fd -t d -d 4 YandexDisk / | head -n 1);
$REMOTE_USER = "broms"
$global:FILE_TRANSFERRED = 0;
Write-Output "---------------------"
Write-Output "KNOWN HOSTS: $HOSTS"
Write-Output "---------------------"
$ACTIVE_HOSTS = "";
$HOSTS = Write-Output $HOSTS | rg "\w+";

Write-Output "[ CHECK CONNECTION ]"
$HOSTS | foreach {
   $server = $_;
   $IS_SERVER_ACTIVE = ping $server -w 1 | grep "100%" | wc | awk '{print $1}';
   if($IS_SERVER_ACTIVE -eq 0) {Write-Output "$_  ACTIVE";} else { Write-Output "$_   DOWN";} 
   if($IS_SERVER_ACTIVE -eq 0) {$ACTIVE_HOSTS = $ACTIVE_HOSTS+ "`n" + $server} 
}

$ACTIVE_HOSTS = Write-Output $ACTIVE_HOSTS | rg "\w+";
$ACTIVE_HOSTS_COUNT =  Write-Output $ACTIVE_HOSTS | wc | awk '{print $1}'
Write-Output "ACTIVE HOSTS: $ACTIVE_HOSTS COUNT: $ACTIVE_HOSTS_COUNT";
#========================================

function SYNCHRO_SESSION($user, $hosts, $storage)
{
$HOSTS = $hosts
$REMOTE_USER = $user;
$LOCAL_STORAGE_DIR = $storage
$global:FILE_TRANSFERRED = 0;
Write-Output "      SYNCHRO SESSION USER: [ $REMOTE_USER] STOR: [$LOCAL_STORAGE_DIR] HOSTS: [$hosts]";
Write-Output "      -------------------------------------"
$IS_SERVER_ACTIVE = 0 
$hosts | foreach {
     $server = $_;
     if($server -eq "middleserver") { $REMOTE_USER = "orizonti" } else { $REMOTE_USER = "broms" }

     $remote_dir = ":/home/$REMOTE_USER" ;
     Write-Output "      SYNCING: $REMOTE_USER@$server$remote_dir";  

     wsl rsync -auz $LOCAL_STORAGE_DIR"/TIPS/*" $REMOTE_USER@$server$remote_dir"/TIPS";  
     $stat = wsl rsync -auz --stats $REMOTE_USER@$server$remote_dir"/TIPS/\*" $LOCAL_STORAGE_DIR"/TIPS/";
     $value = wsl Write-Output $stat | rg -o "transferred: \d+" | rg -o "\d+";
     $global:FILE_TRANSFERRED = $global:FILE_TRANSFERRED + $value;
     Write-Output "      -------------------------------------"
               }
     Write-Output "      TRANSFERRED COUNT: $global:FILE_TRANSFERRED";
}
#
#
if($ACTIVE_HOSTS_COUNT -lt 1) { Write-Output "THERE IS NOT HOST TO SYNCHO, EXIT"; exit;}

Write-Output "=============================================================================="
Write-Output "                                                                          ===="
$try_session = 0; 
while([int]1)  
{ 
  $try_session = $try_session + 1; Write-Output "NUMBER SESSION: $try_session";
  SYNCHRO_SESSION $REMOTE_USER $ACTIVE_HOSTS $LOCAL_STORAGE_DIR
  if($ACTIVE_HOSTS_COUNT -lt 2) { Write-Output "SYNCHRO ONLY ONE HOST, BREAk"; break;}
  if($global:FILE_TRANSFERRED -eq 0) { Write-Output "BREAK"; break;}; 
}
Write-Output "                                                                          ===="
Write-Output "=============================================================================="
#


