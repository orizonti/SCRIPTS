#!/bin/bash
HOSTS=$(cat /etc/hosts | rg "^\d+" | rg -v "127" \
| grep -v "^#" | grep -v "127" | awk '{print $2}')

LOCAL_STORAGE_DIR=$(fd -t d -d 4 YandexDisk / | head -n 1)
REMOTE_USER="broms"

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


#========================================

function SYNCHRO_SESSION
{
local HOSTS=$1; 
local LOCAL_STORAGE_DIR=$2
echo "      SYNCHRO SESSION: STOR: [$LOCAL_STORAGE_DIR/TIPS] HOSTS: [$HOSTS]"

HOSTS=$(echo "$HOSTS" | sed 's/ /\n/g' | rg "\w+") #SPLIT LINES BY SPACES, MAKE LIST
echo "      -------------------------------------"

      FILE_TRANSFERRED=0
      for server in $HOSTS 
      do
        REMOTE_USER="broms"; 
        if [ $server == "middleserver" ]; then REMOTE_USER="orizonti"; fi

        echo " [ SYNC_FILES ]"
        remote_dir=":/home/$REMOTE_USER" 
        echo "      SYNCING: $REMOTE_USER@$server$remote_dir/TIPS"  

        rsync -auz $LOCAL_STORAGE_DIR/TIPS/* $REMOTE_USER@$server$remote_dir/TIPS  
        stat=$(rsync -auz --stats $REMOTE_USER@$server$remote_dir/TIPS/* $LOCAL_STORAGE_DIR/TIPS)
        value=$(echo "$stat" | rg -o "transferred: \d+" | rg -o "\d+")
        FILE_TRANSFERRED=$((FILE_TRANSFERRED + value))
        echo "      -------------------------------------"
      done

echo "      TRANSFERRED COUNT: $FILE_TRANSFERRED"
}

if [ $ACTIVE_HOSTS_COUNT -lt 1 ]; then echo "THERE IS NOT HOST TO SYNCHO, EXIT"; exit; fi

echo "=============================================================================="
echo "                                                                          ===="
  try_session=0 
  while true  
  do
    try_session=$((try_session + 1)); echo "NUMBER SESSION: $try_session";
    SYNCHRO_SESSION "$ACTIVE_HOSTS" "$LOCAL_STORAGE_DIR"
    if [ $ACTIVE_HOSTS_COUNT -lt 2 ]; then echo "SYNCHRO ONLY ONE HOST, BREAk"; break; fi
    if [ $FILE_TRANSFERRED -eq 0 ]; then echo "BREAK"; break; fi
  done
echo "                                                                          ===="
echo "=============================================================================="

#
#echo -e "ACTIVE HOSTS: $ACTIVE_HOSTS " | tr -t "\n" " "; echo ""; #JOIN LINES
#echo -e "ACTIVE HOSTS: $ACTIVE_HOSTS " | sed ':a;{N;s/\n/ /;ba}'; echo ""; #JOIN LINES
