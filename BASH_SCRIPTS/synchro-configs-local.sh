#!/bin/bash
#==================================================

STORAGE_DIR="/mnt/d/STORAGE/YandexDisk/CONFIGS"
VSCODE_LOCAL_DIR="/mnt/c/Users/broms/AppData/Roaming/Code"
NVIM_LOCAL_DIR="/mnt/c/Users/broms/AppData/Local/nvim"
NVIM_LOCAL_DIR_WSL="/home/$USER/.config/nvim"

VIM_LOCAL_CONFIG_WSL="/home/$USER/.vimrc"
VIM_LOCAL_CONFIG="/mnt/c/Users/$USER/_vimrc"

#==================================================

STORAGE_DIR_LINUX="/home/$USER/STORAGE/YandexDisk/CONFIGS"
VSCODE_LOCAL_DIR_LINUX="/home/broms/.config/Code/"
NVIM_LOCAL_DIR_LINUX="/home/broms/.config/nvim"
VIM_LOCAL_CONFIG_LINUX="/home/$USER/_vimrc"
#==================================================

WSL=true;
LINUX=false;

if [ $(uname -a | rg WSL | wc -w) -eq 0 ]; then WSL=false; LINUX=true; fi
if $WSL; then echo "FOUND WSL ENVIRONMENT"; fi
if $LINUX; then echo "FOUND LINUX ENVIRONMENT"; fi


function SYNCHRO_CONFIGS_LINUX()
{
echo "[ STORAGE >> LOCAL ]"
rsync -uv --times $STORAGE_DIR_LINUX/vscode/*.json $VSCODE_LOCAL_DIR_LINUX/User 
rsync -uv --times --recursive --exclude ".git" $STORAGE_DIR_LINUX/nvim/* $NVIM_LOCAL_DIR_LINUX 
rsync -uv --times $STORAGE_DIR_LINUX/vim/_vimrc $VIM_LOCAL_CONFIG_LINUX  


echo "[ STORAGE << LOCAL ]"
rsync -uv --times $VSCODE_LOCAL_DIR_LINUX/User/*.json $STORAGE_DIR_LINUX/vscode
rsync -uv --times --recursive --exclude ".git" $NVIM_LOCAL_DIR_LINUX/* $STORAGE_DIR_LINUX/nvim
rsync -uv --times $VIM_LOCAL_CONFIG_LINUX $STORAGE_DIR_LINUX/vim/_vimrc
echo "=========================================="
}

function SYNCHRO_CONFIGS_WSL()
{
echo "[ STORAGE >> LOCAL ]"
rsync -uv --times $STORAGE_DIR/vscode/*.json $VSCODE_LOCAL_DIR/User 
rsync -uv --times --recursive --exclude ".git" $STORAGE_DIR/nvim/* $NVIM_LOCAL_DIR 
rsync -uv --times $STORAGE_DIR/vim/_vimrc $VIM_LOCAL_CONFIG  

echo "[ STORAGE >> WSL   ]"
rsync -uv --times --recursive --exclude ".git" $STORAGE_DIR/nvim/* $NVIM_LOCAL_DIR_WSL 
rsync -uv --times $STORAGE_DIR/vim/_vimrc $VIM_LOCAL_CONFIG_WSL 

echo "[ STORAGE << WSL   ]"
rsync -uv --times --recursive --exclude ".git" $NVIM_LOCAL_DIR_WSL/* $STORAGE_DIR/nvim
rsync -uv --times $VIM_LOCAL_CONFIG_WSL $STORAGE_DIR/vim/_vimrc 

echo "[ STORAGE << LOCAL ]"
rsync -uv --times $VSCODE_LOCAL_DIR/User/*.json $STORAGE_DIR/vscode
rsync -uv --times --recursive --exclude ".git" $NVIM_LOCAL_DIR/* $STORAGE_DIR/nvim
rsync -uv --times $VIM_LOCAL_CONFIG $STORAGE_DIR/vim/_vimrc


echo "=========================================="
}

if $WSL
then
echo "SYNC IN WSL ENVIRONMENT"

  if [ ! -d $VSCODE_LOCAL_DIR/USER_BACKUP ]; then mkdir $VSCODE_LOCAL_DIR/USER_BACKUP; fi
  cp $VSCODE_LOCAL_DIR/User/*.json $VSCODE_LOCAL_DIR/USER_BACKUP;

echo "SESSION1"; SYNCHRO_CONFIGS_WSL;
echo "SESSION2"; SYNCHRO_CONFIGS_WSL;
fi

if $LINUX
then
echo "SYNC IN WSL ENVIRONMENT"

  if [ ! -d $VSCODE_LOCAL_DIR_LINUX/USER_BACKUP ]; then mkdir $VSCODE_LOCAL_DIR_LINUX/USER_BACKUP; fi
  cp $VSCODE_LOCAL_DIR_LINUX/User/*.json $VSCODE_LOCAL_DIR_LINUX/USER_BACKUP;

SYNCHRO_CONFIGS_LINUX;
fi

