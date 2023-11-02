function SYNCHRO_VIM_CONFIG
{

Write-Output "COPY CONFIG: YANDEX to LOCAL"
rsync -uv --times --recursive --update "./nvim" "~/AppData/Local/" 
rsync -uv --update "vim/_vimrc" "~/_vimrc" 

Write-Output "COPY CONFIG: LOCAL to YANDEX"
rsync -uv --update "~/_vimrc" "./vim/_vimrc"
rsync -uv --times --recursive --update "~/AppData/Local/nvim" "./" 



Write-Output "=========================================="
Write-Output "COPY CONFIG: YANDEX to WSL LOCAl"
wsl rsync -uv --update "/mnt/d/STORAGE/YandexDisk/CONFIGS/vim/_vimrc" "~/_vimrc"
wsl rsync -uv --times --recursive --update "/mnt/d/STORAGE/YandexDisk/CONFIGS/nvim" "~/.config/" 

wsl dos2unix ~/_vimrc
wsl dos2unix ~/.config/nvim/*
wsl dos2unix ~/.config/nvim/lua/*

#Write-Output "COPY CONFIG: WSL LOCAL to YANDEX"
#wsl rsync -uv --update "~/_vimrc" "/mnt/d/STORAGE/YandexDisk/CONFIGS/vim/_vimrc" 
#wsl rsync -uv --times --recursive --update "~/.config/nvim/" "/mnt/d/STORAGE/YandexDisk/CONFIGS/nvim"

Write-Output "=========================================="
}

pushd "D:/STORAGE/YandexDisk/CONFIGS/"
SYNCHRO_VIM_CONFIG
SYNCHRO_VIM_CONFIG 

Read-Host

popd