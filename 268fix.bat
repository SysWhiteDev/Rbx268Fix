@echo off
goto check_Permissions
goto check_roblox

:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Permissions [OK]
    ) else (
        echo Permissions [ERROR]
    )


:check_roblox
    tasklist /fi "ImageName eq RobloxPlayerBeta.exe" /fo csv 2>NUL | find /I "robloxplayerbeta.exe">NUL
    if "%ERRORLEVEL%"=="0" (
        net session >nul 2>&1
        echo Roblox running [ERROR]
        echo Please close all roblox processes and run the script again
        echo Press any key to close this window...
        pause >nul
        exit
    ) else (
        echo Roblox not running [OK]
        goto del_roblox
    )

:del_roblox
    rmdir  "C:\Program Files (x86)\Roblox\Versions\" /Q /S
    rmdir  "C:\Users\%USERNAME%\AppData\Local\Roblox" /Q /S
    echo Roblox deleted [OK]
    goto inst_roblox

:inst_roblox
    if exist installer.exe (
        net session >nul 2>&1
        echo Installer exists [OK]
        echo Waiting for installer to finish...
        installer.exe
        echo Patch was applied with success!
        echo Press any key to close this window...
        pause >nul
        exit
    ) else (
        net session >nul 2>&1
        echo Installer doesn't exist [ERROR]
        echo Installer file wasn't found
        echo Press any key to close this window...
        pause >nul
        exit
    )
    