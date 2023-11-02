ls -recurse -name | rg -e bak -e vux | foreach {echo ("TO_DELETE  " + $_); rm $_}
