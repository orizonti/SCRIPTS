rec_string=cat sync_output.txt | nl | grep receiving | awk '{print $1}' | tail -n 1
words_count=cat sync_output.txt | head -n 23 | tail -n 1 | awk '{$1=$1;print}' | wc -w)
if [[ $words_count -eq 0 ]]; then echo "IS NOT WORDS IN STRING"; fi

val=$(rsync -auzvh --stats orizonti@middleserver:"/home/orizonti/TIPS/*" /mnt/d/TIPS/ | grep transferred: | sed -e 's/[[:space:]]/\n/g' | grep "[0-9]")
val=$(cat test.txt | rg -o "transferred: \d+" | rg -o "\d+"); if [ $val -eq 2 ]; then echo "val==2"; fi;
#sed -e 's/[[:space:]]/\n/g' //SPLIT STRING 

