
echo "CREATE NEW SYSTEM PATHES VARIABLE"
setx SYSTEM "C:\Windows;C:\Windows\system32;"
setx WBEM "C:\Windows\System32\Wbem;"
setx SHELL "C:\Windows\System32\WindowsPowerShell\v1.0\;"


setx DAQ_PILOT "C:\Program Files\Common Files\ADLINK\DAQPilot;"
setx DAQ_MFC "C:\Program Files\Common Files\ADLINK\DAQPilot\Microsoft.VC80.MFC;"
setx DAQ_CRT "C:\Program Files\Common Files\ADLINK\DAQPilot\Microsoft.VC80.CRT;"

setx OPENCV3 "C:\ProgramLibrary\opencv30\build\x64\vc12\bin;"
setx QT5_7 "C:\Qt\Qt5.7.1VS13\5.7\msvc2013_64\bin;"

setx OPEN_BLAS "D:\Library\OpenBLAS\Win64\bin;" 
setx CYGWIN "C:\cygwin64\bin;"
setx NVIM "C:\neovim\nvim-win64\Neovim\bin;"

setx CTAGS "C:\CTags;"
setx JAVA "C:\ProgramData\Oracle\Java\javapath;"
setx CUDA_4_2 "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v4.2\bin;C:\ProgramData\NVIDIA Corporation\NVIDIA GPU Computing SDK 4.2\C\common\bin;C:\ProgramData\NVIDIA Corporation\NVIDIA GPU Computing SDK 4.2\C\common\bin;"


setx CUDA_8 "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\bin;"
setx PHYSX "C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;"


setx MXNET "D:\Library\MX_NET\build110_cuda\install\bin;D:\Library\MXNET\lib;D:\Library\MXNET\3rdparty\bin;"

setx JAI_CAM "C:\ProgramLibrary\JAI\bin\Win32_i86;C:\Program Files\MATLAB\R2017a\runtime\win64;C:\ProgramLibrary\JAI\GenICam\bin\Win32_i86;C:\ProgramLibrary\JAI\GenICam\bin\Win64_x64;C:\ProgramLibrary\JAI\bin;C:\Program Files\MATLAB\R2017a\bin;"


setx STM32 "C:\Program Files (x86)\STMicroelectronics\STM32 ST-LINK Utility\ST-LINK Utility;"
setx CMAKE "C:\Program Files\CMake\bin;"
setx PUTTY "C:\Program Files\PuTTY\;"
setx GIT  "C:\Program Files\Git\cmd;"
setx SFML "C:\ProgramLibrary\SFML-2.4.2_32\bin;"
setx RUBY "C:\Ruby26-x64\bin;"
setx NODEJS "C:\Program Files\nodejs;"

setx WIN_KIT "C:\Program Files (x86)\Windows Kits\8.1\Windows Performance Toolkit\;"
setx IVI_FOUND "C:\Program Files (x86)\IVI Foundation\IVI\bin;C:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin\;C:\Program Files\IVI Foundation\IVI\bin;C:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin\;C:\Program Files (x86)\GtkSharp\2.12\bin;C:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin;"


setx BROM_DNX "C:\Users\Broms\.dnx\bin;"
setx MATLAB "C:\Program Files\MATLAB\R2018b\extern\bin\win64;"
setx MATLAB2 "C:\Program Files\MATLAB\R2018b\bin\win64;"
setx DNVM "C:\Program Files\Microsoft DNX\Dnvm\;"
setx SQL_SERVER "C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;"
setx PYTHON_PATH "C:\Users\Broms\AppData\Local\Programs\Python\Python37\;C:\Users\Broms\AppData\Local\Programs\Python\Python37\Scripts\;"
setx PYCHARM ${env:PyCharm Community Edition}

echo "PRESS ANY KEY"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

echo "CREATE GLOGAL VARIABLE TO PATCHES"
$Global:PATH_BROM = $env:GIT + $env:MATLAB + $env:MATLAB2
$Global:PATH_BROM_NO_NEED = $env:CTAGS + $env:PUTTY

 
$Global:PATH_SYSTEM =$env:SYSTEM + $env:WBEM + $env:JAVA + $env:SQL_SERVER


$Global:PATH_PROGRAMMING =$env:STM32 + $env:QT5_7 + $env:PYTHON_PATH + $env:OPENCV3 + $env:CMAKE + $env:PYCHARM + $env:RUBY + $env:NODEJS + $env:CTAGS

$Global:PATH_PROGRAMMING_NO_NEED =$env:CUDA_4_2 + $env:CMAKE + $env:SFML     
                         

$Global:PATH_OTHER = $env:PHYSX + $env:IVI_FOUND 

$Global:PATH_OLD_BINNARY = $env:DAQ_PILOT + $env:DAQ_MFC+$env:DAQ_MFC + $env:DAQ_CRT



echo "NEW PATH BROM"
echo "*********************************************"
$Global:PATH_BROM
echo "*********************************************"

echo "NEW PATH SYTEM"
echo "*********************************************"
$Global:PATH_SYSTEM
echo "*********************************************"

echo "NEW PATH PROGRAMMING"
echo "*********************************************"
$Global:PATH_PROGRAMMING
echo "*********************************************"

echo "PRESS ANY KEY"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$Global:PATH_BROM = $Global:PATH_BROM + $Global:PATH_PROGRAMMING 

setx PATH_BROM $Global:PATH_BROM 
echo "SET PATH BROM TO SYSTEM VAR"
setx PATH_PROGRAMMING $Global:PATH_PROGRAMMING 
echo "SET PATH PROGRAMMING TO SYSTEM VAR"
setx PATH_SYSTEM $Global:PATH_SYSTEM -m 
echo "SET PATH_SYSTEM TO SYSTEM VAR"

echo "======================================================"
setx PATH %PATH_BROM% 
echo "broms PATH SET TO PATH_BROM + PATH_PROGRAMMING"

setx PATH %PATH_SYSTEM% -m
echo "system PATH SET TO PATH_SYSTEM"
echo "======================================================"

echo "PRESS ANY KEY"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
