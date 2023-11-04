#!/bin/bash
HOSTS=$(cat /etc/hosts | rg "^\d+" | rg -v "127" \
| grep -v "^#" | grep -v "127" | awk '{print $2}')


FILE_TRANSFERRED=0
echo "---------------------"
echo -e "KNOWN HOSTS: $HOSTS " | tr -t "\n" " "; echo ""; #JOIN LINES
echo "---------------------"
ACTIVE_HOSTS=""

echo "[ CHECK CONNECTION ]"
for server in $HOSTS
do
         IS_SERVER_ACTIVE=$(ping "$server" -w 1 | grep "100%" | wc | awk '{print $1}')
   if [ $IS_SERVER_ACTIVE -eq 0 ]; then echo "$server  ACTIVE"; else  echo "$server   DOWN"; fi
   if [ $IS_SERVER_ACTIVE -eq 0 ]; then ACTIVE_HOSTS="$ACTIVE_HOSTS$server "; fi
done

ACTIVE_HOSTS_COUNT=$(echo "$ACTIVE_HOSTS" | sed 's/ /\n/g' | wc | awk '{print $1}')


echo $USER
STORAGE_LINUX="/home/$USER/STORAGE/YandexDisk/CONFIGS"
STORAGE_SERVER="/home/orizonti/STORAGE/CONFIGS"
STORAGE_WINDOWS="/cygdrive/d/STORAGE/YandexDisk/CONFIGS"

LOCAL_STORAGE=$STORAGE_LINUX;  if [ -d $STORAGE_SERVER ]; then LOCAL_STORAGE=$STORAGE_SERVER; fi 
echo "LOCAL STORAGE: $LOCAL_STORAGE"
echo "============="

#========================================
function SYNCHRO_SESSION
{
echo "      -------------------------------------"
local HOSTS=$1; 
local LOCAL_STORAGE_DIR=$2
echo "      SYNCHRO SESSION: STOR: [$LOCAL_STORAGE_DIR] HOSTS: [$HOSTS]"

HOSTS=$(echo "$HOSTS" | sed 's/ /\n/g' | rg "\w+") #SPLIT LINES BY SPACES, MAKE LIST
echo "      -------------------------------------"

      SYNC_FLAG=false
      FILE_TRANSFERRED=0
      for server in $HOSTS 
      do
        REMOTE_USER="broms"; 
        if [ $server == "middleserver" ]; then REMOTE_USER="orizonti"; fi

        #is_linux=$(ssh $REMOTE_USER@$server uname -a | sed 's/ /\n/g' | grep -E "Linux" 1>&2 | wc -w)

        REMOTE_STORAGE=$STORAGE_LINUX;  
        if ssh $REMOTE_USER@$server test -d $STORAGE_SERVER ; then REMOTE_STORAGE=$STORAGE_SERVER; fi 
        if ssh $REMOTE_USER@$server test -d $STORAGE_WINDOWS ; then REMOTE_STORAGE=$STORAGE_WINDOWS; fi 

        echo "SYNC: LOCAL [$LOCAL_STORAGE_DIR] REMOTE [$REMOTE_STORAGE] : $server";

        rsync -auzv --exclude ".git" $LOCAL_STORAGE/* $REMOTE_USER@$server:$REMOTE_STORAGE 
        stat=$(rsync -auzv --stats --exclude ".git"  $REMOTE_USER@$server:$REMOTE_STORAGE/* $LOCAL_STORAGE)
        value=$(echo "$stat" | rg -o "transferred: \d+" | rg -o "\d+")
        FILE_TRANSFERRED=$((FILE_TRANSFERRED + value))

        echo "      -------------------------------------"

      done

echo "      TRANSFERRED COUNT: $FILE_TRANSFERRED"
}

if [ $ACTIVE_HOSTS_COUNT -lt 1 ]; then echo "THERE IS NOT HOST TO SYNCHO, EXIT"; exit; fi


SYNCHRO_SESSION "$ACTIVE_HOSTS" "$LOCAL_STORAGE"

#echo "=============================================================================="
#echo "                                                                          ===="
#  try_session=0 
#  while true  
#  do
#    try_session=$((try_session + 1)); echo "NUMBER SESSION: $try_session";
#    SYNCHRO_SESSION "$ACTIVE_HOSTS" "$LOCAL_STORAGE_DIR"
#    if [ $ACTIVE_HOSTS_COUNT -lt 2 ]; then echo "SYNCHRO ONLY ONE HOST, BREAk"; break; fi
#    if [ $FILE_TRANSFERRED -eq 0 ]; then echo "BREAK"; break; fi
#  done
#echo "                                                                          ===="
#echo "=============================================================================="

#ARRAY TO LIST  ${ARRAY[0]}; ${ARRAY[@]}
#
#echo -e "ACTIVE HOSTS: $ACTIVE_HOSTS " | tr -t "\n" " "; echo ""; #JOIN LINES
#echo -e "ACTIVE HOSTS: $ACTIVE_HOSTS " | sed ':a;{N;s/\n/ /;ba}'; echo ""; #JOIN LINES
