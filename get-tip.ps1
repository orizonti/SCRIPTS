#GET_TIP TAG TIP_NAME
#GET_TIP TAG LIST

$root = "D:/TIPS/" 

#FIND TIPS DIR
if(test-path D:/STORAGE/YandexDisk/TIPS) {$root = "D:/STORAGE/YandexDisk/TIPS"}
if(test-path D:/TIPS) {$root = "D:/TIPS/"}
write-host
$EXAMPLE_NAME = "LIST"
$TAG_NAME = "ALL"
$CONSOLE_FLAG = 0

if($args.Count -eq 1)
{
$CONSOLE_FLAG = 1;
$EXAMPLE_NAME = $args[0].toUpper()
}
if($args.Count -eq 2)
{
$CONSOLE_FLAG = 1;
$EXAMPLE_NAME = $args[0].toUpper()
$TAG_NAME = $args[1].toUpper()
}

Write-Host ("GET TAGS: " + $TAG_NAME + " " + $EXAMPLE_NAME)

write-host "-----------------------------------------"
#LIST AVAILABLE EXAMPLES
$examples_dir= ""; if($EXAMPLE_NAME -like "LIST") 
                   {
                    #LIST OF ALL EXAMPLES DIR
                    $examples_dir = Get-ChildItem ($root) -recurse -directory -name | grep "EXAMPLE";
                    $tags = $examples_dir.replace("\EXAMPLE","");
                    write-host("ALL TAGS")
                    write-host($tags)
                    write-host("==============")

                    #LIST OF EXAMPLES DIR FOR TAG(SHELL CPP)
                    if($TAG_NAME -notlike "ALL") {$examples_dir = ($examples_dir | grep $TAG_NAME)} 
                    #DISPLAY ALL EXAMPLES FOT TAG, CLEAR _EXM SUFFIX at FILES
                    $examples_dir | foreach { Write-Host $_; 
                                              $items = (Get-ChildItem ($root + $_) -file -name).replace("_EXM.txt","");
                                              Write-Host ("[" + $items + "]"); Write-Host ""
                                            }
                    write-host "-----------------------------------------"
                    if(-not $CONSOLE_FLAG) {write-host "PRESS KEY"; read-host}
                    exit
                   }

#FIND AND PRINT TIP
write-host "-----------------------------------------"
#GET _EXM files for EXAMPLE_NAME
$list = Get-ChildItem $root -recurse -name -file | grep ($EXAMPLE_NAME+ "_EXM.txt") 
write-host $list
if($list.Count) 
{ 
    $list | foreach { bat ($root +$_) -l powershell -p};
    write-host "-----------------------------------------"
    exit
}
write-host "FILE: " + $EXAMPLE_NAME + " NOT FOUND"
        