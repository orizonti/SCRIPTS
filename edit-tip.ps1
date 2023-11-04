$root = "D:/TIPS/" 

if(test-path D:/STORAGE/YandexDisk/TIPS) {$root = "D:/STORAGE/YandexDisk/TIPS"}
if(test-path D:/TIPS) {$root = "D:/TIPS/"}
write-host
$EXAMPLE_NAME = $args[0].toUpper()

$list = Get-ChildItem $root -recurse -name -file | grep ($EXAMPLE_NAME+ "_EXM.txt") 
write-host "SET FT BASH";
if($list.Count) 
{ 
    $list | foreach { nvim ($root +$_) "-c set ft=bash"};
    exit
}
write-host "FILE: " + $EXAMPLE_NAME + " NOT FOUND"
        