$ROOT_DIR = "D:/STORAGE/YandexDisk/"
$DEST_ROOT = "../.."
$LOCAL_PROJECTS = "./DEVELOPMENT/PROJECTS/"

Set-Location "D:/"
$EXCLUDE_DIRS = "REMOTE","TEST_PROJECT_DIR","GAME_PROJECT_DIR","OLD_PROJECTS","ROBO_CAR"
$PROJECT_DIRS = $(Get-ChildItem $LOCAL_PROJECTS -exclude $EXCLUDE_DIRS  -directory -Name).split(";");
$TEST_PROJECT_DIRS = $(Get-ChildItem ($LOCAL_PROJECTS + "TEST_PROJECT_DIR") -exclude $EXCLUDE_DIRS -directory -Name).split(";");

$DIRS_LIST = @()

$DEST_DIR = $DEST_ROOT + "/DEVELOPMENT/PROJECTS"
$PROJECT_DIRS | foreach {
                $DIRS_LIST = $DIRS_LIST + ($LOCAL_PROJECTS + $_ + ":$DEST_DIR");
                        }

$DEST_DIR = $DEST_ROOT + "/DEVELOPMENT/PROJECTS/TEST_PROJECT_DIR"
$TEST_PROJECT_DIRS | foreach {
                    $DIRS_LIST = $DIRS_LIST + ($LOCAL_PROJECTS + "TEST_PROJECT_DIR/" + $_ + ":$DEST_DIR");
                             }



Set-Location $ROOT_DIR
Write-Output "=================================="
Write-Output "SYNCRONIZE SOURCE:$ROOT_DIR  DESTINATION:$DEST_ROOT"
Write-Output "PARAM: -uq --recursive --update --times"
#Write-Output $DIRS_LIST
Write-Output "=================================="
$DIRS_LIST | ForEach -Parallel {
                               $paths = $_.split(":"); Write-Output ($paths[0] + " TO: " + $paths[1])
                               rsync -uq --progress --exclude=build* --recursive --update --times $paths[0] $paths[1]; 
                               }
Write-Output "=================================="
Set-Location "D:/STORAGE" 

Write-Host "PRESS KEY"
Read-Host