function SYNCHRO_CONFIGS
{
Write-Output ""

if(-not (Test-Path ~/AppData/Roaming/Code/UserBackup) ) {mkdir ~/AppData/Roaming/Code/UserBackup} 
Copy-Item ~/AppData/Roaming/Code/User/*.json ~/AppData/Roaming/Code/UserBackup;

Write-Output "[ YANDEX >> LOCAL ]"
rsync -uv --times "./VSCODE/*.json" "~/AppData/Roaming/Code/User/" 
rsync -uv --times --recursive --exclude ".git" "./nvim" "~/AppData/Local/" 

Write-Output "[ LOCAL >> YANDEX ] "
rsync -uv --times "~/AppData/Roaming/Code/User/*.json" "./VSCODE" 
rsync -uv --times --recursive --exclude ".git" "~/AppData/Local/nvim" "./" 

Write-Output "[ YANDEX >> WSL ] "
#wsl unix2dos -k ~/_vimrc;  wsl unix2dos -k ~/.config/nvim/*;  wsl unix2dos -k ~/.config/nvim/lua/*
    wsl rsync -uv --times "/mnt/d/STORAGE/YandexDisk/CONFIGS/vim/_vimrc" "~/_vimrc"
    wsl rsync -uv --times --recursive --exclude ".git" "/mnt/d/STORAGE/YandexDisk/CONFIGS/nvim" "~/.config/" 

Write-Output "[ WSL >> YANDEX ] "
    wsl rsync -uv --times "~/_vimrc" "/mnt/d/STORAGE/YandexDisk/CONFIGS/vim/_vimrc" 
    wsl rsync -uv --times --recursive --exclude ".git" "~/.config/nvim/" "/mnt/d/STORAGE/YandexDisk/CONFIGS/nvim"
#wsl dos2unix -k ~/_vimrc;  wsl dos2unix -k ~/.config/nvim/*;  wsl dos2unix -k ~/.config/nvim/lua/*


Write-Output "=========================================="
}

pushd "D:/STORAGE/YandexDisk/CONFIGS/"

Write-Output "SESSION1"
SYNCHRO_CONFIGS
Write-Output "SESSION2"
SYNCHRO_CONFIGS
#Read-Host

popd 

#$WSL_YANDEX_DIR="/mnt/d/STORAGE/YandexDisk/CONFIGS"
#wsl unix2dos -k "$WSL_YANDEX_DIR/vim/_vimrc"; wsl unix2dos -k "$WSL_YANDEX_DIR/nvim/*"; wsl unix2dos -k "$WSL_YANDEX_DIR/nvim/lua/*"