#!/bin/bash
#
parameter="${1^^}"
parameter="${2^^}"
script_name=$0
#list_dir=$(ls -R /mnt/d/TIPS) 
list_dir=$(ls -R /mnt/d/TIPS | grep _EXM) 
echo $list_dir
echo "script name : $script_name parameter: $parameter"
echo 'script name : $script_name parameter: $parameter'



#STRINGS WORK
echo "CONVERT TO UPPER LOWER CASE"
#text="Hello!" echo "${text^^}"
text="Hello"; text="${text^^}"; echo "$text"
text="GOODBY"; text="${text,,}"; echo "$text"


#Splitting strings into an array
echo "     [ TEST readarray ]"
string="apple,banana,orange"
readarray -d , -t fruits <<< "$string"
echo "${fruits[1]}"
echo "================="
echo "-----------------Printing all the values-----"
echo ${fruits[@]}
echo "                 Method 1:"
echo ${fruits[*]}
echo "                 Method 2:"
echo ${fruits[@]}
 
echo "-----------------Printing values from a particular index say 3-------------------"
echo "                 Method 1:"
echo ${fruits[*]:2}
echo "                 Method 2:"
echo ${fruits[*]:1}
echo "================="
for fn in ${fruits[@]}; do
    echo "FRUIT IS: $fn"
done

#for var in first second third fourth fifth
#do
#echo The  $var item
#done


exit 0

echo $DIRSTACK
#echo $EDITOR
#echo $EUID 
#echo $UID 
#echo $FUNCNAME
#echo $GROUPS 
#echo $HOME -
#echo $HOSTNAME
#echo $HOSTTYPE
#echo $LC_CTYPE 
#echo $OLDPWD
#echo $OSTYPE
#echo $PATH
#echo $PPID
echo $SECONDS 
#echo $# 
#echo $* 
#echo $@ 
echo "ARG NUMBER $#"
echo "PARAM COL $*"
echo "PARAM ROW $@"
echo "LAST PROCESS PID $!"
echo "SCRIPT PID $$"

if [ $# > 0 ]; then
  echo "PARAM AVAILABLE"
else
  echo "PARAM NONE"
fi

source="/home/broms/DEVELOPMENT/PROJECTS/SCRIPTS/BASH_SCRIPTS/TestScript.sh"
dest="/mnt/d/TRASH/TestScript.sh"
echo $source
echo $dest
echo -n "Enter Number: "

nb=1
nc=2
if [ $nb == $nc ]; then
  echo "Number is equal"
else
  echo "Number is not equal"
fi

a="abc"
b="def"

# Equality Comparison
if [ "$a" == "$b" ]; then
    echo "Strings match"
else
    echo "Strings don't match"
fi

echo "==================="
if [ "$a" != "$b" ]; then
    echo "Strings don't match"
else
    echo "Strings match"
fi

echo "==================="
if [ "$a" \< "$b" ]; then
    echo "$a is lexicographically smaller then $b"
elif [ "$a" \> "$b" ]; then
    echo "$b is lexicographically smaller than $a"
else
    echo "Strings are equal"
fi

echo "==================="
echo "TEST STRINGS"
string="Bash String Operations"; echo ${string:0:3}
echo "TEST STRINGS REPLACE"
string="Bash String Operations"; echo ${string/String/Scripts}
echo "TEST STRINGS CONCATENATION"
string1="Bash"; string2="Scripts"; echo $string1$string2
echo "TEST STRINGS SUBSTRING" #${string:position:length}
sentence="The quick brown fox jumps over the lazy dog"; substring="${sentence:10:5}"; echo $substring

filename="example.pdf"  #expr start . [number non dot char]* till end $
extension=$(echo $filename | grep -o '\.[^\.]*$')
echo $extension


echo "NUMERICAL COMPARE"
num1=10
num2=5
echo "NUM1: $num1"; echo "NUM2: $num2"
if [[ "$num1" -lt "$num2" ]]; then
  echo "$num1 < $num2 true"
else
  echo "$num2 < $num1 true"
fi

if [[ $num1 -lt $num2 ]]; then
  echo "$num1 < $num2 true"
else
  echo "$num2 < $num1 true"
fi

numm1=3
numm2=5

if (( $numm1 < $numm2 )); then
  echo "$numm1 less $numm2"
else
  echo "$numm1 more $numm2"
fi

#((...)) вычисляются арифметические выражения и возвращается их результат. 
#a=$(( 5 + 3 )); a = 8  
#позволяют работать с переменными в стиле языка C
#(( a = 23 ))  # Присвоение переменной в стиле C, с обоих строн от "=" стоят пробелы.
#(( a++ ))     # Пост-инкремент 'a', в стиле C.
#(( a-- ))     # Пост-декремент 'a', в стиле C.
#(( ++a ))     # Пред-инкремент 'a', в стиле C.
#(( --a ))     # Пред-декремент 'a', в стиле C.

