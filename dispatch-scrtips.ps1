Copy-Item -Force D:/SCRIPTS/synchro-storage.ps1 D:/STORAGE; write-host "synchro_storage.ps1 -> D:/STORAGE"
Copy-Item -Force D:/SCRIPTS/synchro-workdir.ps1 D:/DEVELOPMENT; write-host "synchro_workdir.ps1 -> D:/DEVELOPMENT"
Copy-Item -Force D:/SCRIPTS/synchro-storage.ps1 D:/STORAGE/YandexDisk/CONFIGS/; write-host "synchro_storage.ps1 -> D:/STORAGE"
Copy-Item -Force D:/SCRIPTS/clean-backup.ps1  D:/DEVELOPMENT/PROJECTS/UML;     write-host "clean_backup.ps1 -> D:/DEVELOPMENT/PROJECTS/UML"
Copy-Item -Force D:/SCRIPTS/clean-backup.ps1 D:/SCHEMES/VPP;     write-host "clean_backup.ps1 -> D:/SCHEMES/VPP;"
Copy-Item -Force D:/SCRIPTS/get-tip.ps1 D:/TIPS;     write-host "get_tip.ps1 -> D:/TIPS"
Copy-Item -Force D:/SCRIPTS/edit-tip.ps1 D:/TIPS;     write-host "edit_tip.ps1 -> D:/TIPS"
write-host "PRESS KEY"
read-host
