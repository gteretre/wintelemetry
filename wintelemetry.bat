@echo off
REM Windows Telemetry & OneDrive Toggle Script

REM --- Force Admin Privileges ---
openfiles >nul 2>&1
if not "%errorlevel%"=="0" (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

REM Registry keys and values
set "KEY1=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
set "VAL1=AllowTelemetry"
set "KEY2=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
set "VAL2=AllowDeviceNameInTelemetry"
set "KEY3=HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows"
set "VAL3=CEIPEnable"
set "KEY4=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
set "VAL4=AITEnable"
set "KEY5=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
set "VAL5=value"
set "KEY6=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
set "VAL6=DoNotShowFeedbackNotifications"
set "KEY7=HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting"
set "VAL7=Disabled"
set "KEY8=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
set "VAL8=DisableInventory"
set "KEY9=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
set "VAL9=DisableTelemetry"
set "KEY10=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
set "VAL10=AllowCortana"
set "KEY11=HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
set "VAL11=DisabledByGroupPolicy"
set "KEY12=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
set "VAL12=DisableTailoredExperiencesWithDiagnosticData"
set "KEY13=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowSenseHotSpots"
set "VAL13=value"
set "KEY14=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
set "VAL14=value"
set "KEY15=HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
set "VAL15=DisableLocation"
set "KEY16=HKLM\SOFTWARE\Policies\Microsoft\Windows\System"
set "VAL16=PublishUserActivities"
set "KEY17=HKLM\SOFTWARE\Policies\Microsoft\Windows\System"
set "VAL17=UploadUserActivities"
set "KEY18=HKLM\SOFTWARE\Policies\Microsoft\Windows\System"
set "VAL18=EnableActivityFeed"
set "KEY19=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
set "VAL19=Start_TrackProgs"
set "KEY20=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
set "VAL20=ConnectedSearchUseWeb"
set "KEY21=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
set "VAL21=ConnectedSearchUseWebOverMeteredConnections"
set "KEY22=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
set "VAL22=DisableWindowsSpotlightFeatures"
set "KEY23=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
set "VAL23=DisableWindowsSpotlightOnActionCenter"
set "KEY24=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
set "VAL24=DisableWindowsSpotlightOnSettings"
set "KEY25=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
set "VAL25=DisableWindowsSpotlightWindowsWelcomeExperience"
set "KEY26=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
set "VAL26=LetAppsRunInBackground"

REM Descriptions for each key
set "DESC1=Data Collection (AllowTelemetry)"
set "DESC2=Device Name in Telemetry (AllowDeviceNameInTelemetry)"
set "DESC3=Customer Experience Improvement Program (CEIPEnable)"
set "DESC4=Application Telemetry (AITEnable)"
set "DESC5=WiFi HotSpot Reporting (AllowWiFiHotSpotReporting)"
set "DESC6=Windows Feedback Notifications (DoNotShowFeedbackNotifications)"
set "DESC7=Windows Error Reporting (Disabled)"
set "DESC8=Inventory Collector (DisableInventory)"
set "DESC9=AppCompat Telemetry (DisableTelemetry)"
set "DESC10=Cortana (AllowCortana)"
set "DESC11=Advertising ID (DisabledByGroupPolicy)"
set "DESC12=Tailored Experiences (DisableTailoredExperiencesWithDiagnosticData)"
set "DESC13=WiFi Sense HotSpots (AllowSenseHotSpots)"
set "DESC14=WiFi Sense AutoConnect (AllowAutoConnectToWiFiSenseHotspots)"
set "DESC15=Location Tracking (DisableLocation)"
set "DESC16=Activity History (PublishUserActivities)"
set "DESC17=Activity History Upload (UploadUserActivities)"
set "DESC18=Timeline (EnableActivityFeed)"
set "DESC19=App Launch Tracking (Start_TrackProgs)"
set "DESC20=Search Online (ConnectedSearchUseWeb)"
set "DESC21=Search Web Over Metered (ConnectedSearchUseWebOverMeteredConnections)"
set "DESC22=Spotlight Features (DisableWindowsSpotlightFeatures)"
set "DESC23=Spotlight Action Center (DisableWindowsSpotlightOnActionCenter)"
set "DESC24=Spotlight Settings (DisableWindowsSpotlightOnSettings)"
set "DESC25=Spotlight Welcome Experience (DisableWindowsSpotlightWindowsWelcomeExperience)"
set "DESC26=Background Apps (LetAppsRunInBackground)"

:mainmenu
cls
setlocal enabledelayedexpansion

ECHO ===================================================
ECHO      DEBLOAT WINDOWS
ECHO ===================================================

set "all_disabled=1"
set "any_enabled=0"

REM Check telemetry status
for %%I in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26) do (
    for /f "tokens=3" %%V in ('reg query !KEY%%I! /v !VAL%%I! 2^>nul') do (
        if not "%%V"=="0x0" set "all_disabled=0"
        if not "%%V"=="0x0" set "any_enabled=1"
    )
)

REM Show telemetry status
ECHO.
ECHO Telemetry Status:
for %%I in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26) do (
    set "desc=!DESC%%I!"
    set "found=0"
    for /f "tokens=3" %%V in ('reg query !KEY%%I! /v !VAL%%I! 2^>nul') do (
        set "found=1"
        REM Unified logic for all keys
        if "%%V"=="0x0" (
            echo   [Disabled] !desc!
        ) else if "%%V"=="0x1" (
            if "%%I"=="6" (
                echo   [Disabled] !desc!
            ) else if "%%I"=="7" (
                echo   [Disabled] !desc!
            ) else if "%%I"=="11" (
                echo   [Disabled] !desc!
            ) else if "%%I"=="8" (
                echo   [Disabled] !desc!
            ) else if "%%I"=="9" (
                echo   [Disabled] !desc!
            ) else (
                echo   [Enabled]  !desc!
            )
        ) else (
            echo   [Enabled]  !desc!
        )
    )
    if !found! == 0 echo   [Not Set] !desc!
)

REM Show background service status
ECHO.
ECHO Background Services Status:
call :servicestatus DiagTrack "Connected User Experiences and Telemetry"
call :servicestatus dmwappushservice "WAP Push Message Routing Service"
call :servicestatus RetailDemo "Retail Demo Service"
call :servicestatus WMPNetworkSvc "Windows Media Player Network Sharing Service"
call :servicestatus MapsBroker "Downloaded Maps Manager"
call :servicestatus Fax "Fax Service"
call :servicestatus RemoteRegistry "Remote Registry"
REM call :servicestatus SysMain "Superfetch (disable if SSD)"

REM Tips section for additional services
ECHO.
ECHO Tips: For further privacy/performance, consider disabling these services manually in Windows Services (services.msc):
ECHO   - SysMain (Superfetch, especially if you use SSD)
ECHO   - Xbox services (XblGameSave, XboxNetApiSvc, XboxGipSvc, Xbox Accessory Management)
ECHO   - Print Spooler (if you do not use a printer)
ECHO   - Bluetooth Support Service (if you do not use Bluetooth)
ECHO   - Windows Search (if you do not use search indexing)
ECHO   - Windows Update Medic Service (WaaSMedicSvc)
ECHO   - Windows Error Reporting Service (WerSvc)
ECHO   - Remote Desktop Services (TermService)
ECHO   - Smart Card (SCardSvr)
ECHO ---------------------------------------------------

REM Check OneDrive status
set "ODStatus=Enabled"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" 2>nul | find "0x1" >nul && set "ODStatus=Disabled"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive 2>nul | find /i "OneDrive.exe" >nul || set "ODStatus=Disabled"
ECHO.
ECHO OneDrive Status: [%ODStatus%]

ECHO ---------------------------------------------------
ECHO.
ECHO [1] Disable ALL telemetry options
ECHO [2] Disable and block OneDrive
ECHO [3] Uninstall OneDrive completely
ECHO [4] Disable useless background apps and services
ECHO.
ECHO [Q] Enable ALL telemetry options
ECHO [W] Enable and unblock OneDrive
ECHO.
set /p userchoice=Choose an option and press Enter: 
if /i "%userchoice%"=="1" goto disableall
if /i "%userchoice%"=="2" goto disableonedrive
if /i "%userchoice%"=="3" goto uninstallonedrive
if /i "%userchoice%"=="4" goto disablebgapps
if /i "%userchoice%"=="q" goto enableall
if /i "%userchoice%"=="w" goto enableonedrive
ECHO.
ECHO Invalid choice. Please enter 1, 2, 3, 4, Q, or W.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

goto :eof
:enableall
ECHO.
ECHO Enabling all telemetry options...
reg add "%KEY1%" /v %VAL1% /t REG_DWORD /d 1 /f >nul
reg add "%KEY2%" /v %VAL2% /t REG_DWORD /d 1 /f >nul
reg add "%KEY3%" /v %VAL3% /t REG_DWORD /d 1 /f >nul
reg add "%KEY4%" /v %VAL4% /t REG_DWORD /d 1 /f >nul
reg add "%KEY5%" /v %VAL5% /t REG_DWORD /d 1 /f >nul
reg add "%KEY6%" /v %VAL6% /t REG_DWORD /d 0 /f >nul
reg add "%KEY7%" /v %VAL7% /t REG_DWORD /d 0 /f >nul
reg add "%KEY8%" /v %VAL8% /t REG_DWORD /d 0 /f >nul
reg add "%KEY9%" /v %VAL9% /t REG_DWORD /d 0 /f >nul
reg add "%KEY10%" /v %VAL10% /t REG_DWORD /d 1 /f >nul
reg add "%KEY11%" /v %VAL11% /t REG_DWORD /d 0 /f >nul
reg add "%KEY12%" /v %VAL12% /t REG_DWORD /d 0 /f >nul
reg add "%KEY13%" /v %VAL13% /t REG_DWORD /d 1 /f >nul
reg add "%KEY14%" /v %VAL14% /t REG_DWORD /d 1 /f >nul
reg add "%KEY15%" /v %VAL15% /t REG_DWORD /d 0 /f >nul
reg add "%KEY16%" /v %VAL16% /t REG_DWORD /d 1 /f >nul
reg add "%KEY17%" /v %VAL17% /t REG_DWORD /d 1 /f >nul
reg add "%KEY18%" /v %VAL18% /t REG_DWORD /d 1 /f >nul
reg add "%KEY19%" /v %VAL19% /t REG_DWORD /d 1 /f >nul
reg add "%KEY20%" /v %VAL20% /t REG_DWORD /d 1 /f >nul
reg add "%KEY21%" /v %VAL21% /t REG_DWORD /d 1 /f >nul
reg add "%KEY22%" /v %VAL22% /t REG_DWORD /d 0 /f >nul
reg add "%KEY23%" /v %VAL23% /t REG_DWORD /d 0 /f >nul
reg add "%KEY24%" /v %VAL24% /t REG_DWORD /d 0 /f >nul
reg add "%KEY25%" /v %VAL25% /t REG_DWORD /d 0 /f >nul
reg add "%KEY26%" /v %VAL26% /t REG_DWORD /d 1 /f >nul
ECHO All telemetry options have been enabled.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

goto :eof
:disableall
ECHO.
ECHO Disabling all telemetry options...
reg add "%KEY1%" /v %VAL1% /t REG_DWORD /d 0 /f >nul
reg add "%KEY2%" /v %VAL2% /t REG_DWORD /d 0 /f >nul
reg add "%KEY3%" /v %VAL3% /t REG_DWORD /d 0 /f >nul
reg add "%KEY4%" /v %VAL4% /t REG_DWORD /d 0 /f >nul
reg add "%KEY5%" /v %VAL5% /t REG_DWORD /d 0 /f >nul
reg add "%KEY6%" /v %VAL6% /t REG_DWORD /d 1 /f >nul
reg add "%KEY7%" /v %VAL7% /t REG_DWORD /d 1 /f >nul
reg add "%KEY8%" /v %VAL8% /t REG_DWORD /d 1 /f >nul
reg add "%KEY9%" /v %VAL9% /t REG_DWORD /d 1 /f >nul
reg add "%KEY10%" /v %VAL10% /t REG_DWORD /d 0 /f >nul
reg add "%KEY11%" /v %VAL11% /t REG_DWORD /d 1 /f >nul
reg add "%KEY12%" /v %VAL12% /t REG_DWORD /d 1 /f >nul
reg add "%KEY13%" /v %VAL13% /t REG_DWORD /d 0 /f >nul
reg add "%KEY14%" /v %VAL14% /t REG_DWORD /d 0 /f >nul
reg add "%KEY15%" /v %VAL15% /t REG_DWORD /d 1 /f >nul
reg add "%KEY16%" /v %VAL16% /t REG_DWORD /d 0 /f >nul
reg add "%KEY17%" /v %VAL17% /t REG_DWORD /d 0 /f >nul
reg add "%KEY18%" /v %VAL18% /t REG_DWORD /d 0 /f >nul
reg add "%KEY19%" /v %VAL19% /t REG_DWORD /d 0 /f >nul
reg add "%KEY20%" /v %VAL20% /t REG_DWORD /d 0 /f >nul
reg add "%KEY21%" /v %VAL21% /t REG_DWORD /d 0 /f >nul
reg add "%KEY22%" /v %VAL22% /t REG_DWORD /d 1 /f >nul
reg add "%KEY23%" /v %VAL23% /t REG_DWORD /d 1 /f >nul
reg add "%KEY24%" /v %VAL24% /t REG_DWORD /d 1 /f >nul
reg add "%KEY25%" /v %VAL25% /t REG_DWORD /d 1 /f >nul
reg add "%KEY26%" /v %VAL26% /t REG_DWORD /d 0 /f >nul
ECHO All telemetry options have been disabled.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

goto :eof
:disableonedrive
ECHO.
ECHO Disabling and blocking OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
REM Check if OneDrive service exists before stopping/configuring
sc query OneDrive >nul 2>&1 && (
    sc stop OneDrive >nul 2>&1
    sc config OneDrive start= disabled >nul 2>&1
)
ECHO OneDrive has been disabled and blocked.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

goto :eof
:enableonedrive
ECHO.
ECHO Enabling and unblocking OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 0 /f >nul
REM Optionally restore OneDrive autorun (user may need to log in again)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "%SystemRoot%\System32\OneDrive.exe /background" /f >nul
REM Check if OneDrive service exists before configuring
sc query OneDrive >nul 2>&1 && sc config OneDrive start= demand >nul 2>&1
ECHO OneDrive has been enabled and unblocked.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

goto :eof
:uninstallonedrive
ECHO.
ECHO Uninstalling OneDrive completely...
REM Kill OneDrive if running
TASKKILL /F /IM OneDrive.exe >nul 2>&1
REM Run the OneDrive uninstaller (system32 for 64-bit, SysWOW64 for 32-bit)
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
)
REM Remove leftover OneDrive folders
rd /s /q "%UserProfile%\OneDrive" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
REM Remove OneDrive from explorer sidebar
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
ECHO OneDrive has been uninstalled and cleaned up.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu

:end
ECHO.
ECHO Done. Some changes may require a restart.
ECHO Press any key to exit...
pause >nul
endlocal

:servicestatus
REM Usage: call :servicestatus <servicename> <description>
setlocal enabledelayedexpansion
set "state=Unknown"
set "starttype=Unknown"
for /f "tokens=3" %%S in ('sc query %1 2^>nul ^| findstr /i STATE') do set "state=%%S"
for /f "tokens=3" %%S in ('sc qc %1 2^>nul ^| findstr /i START_TYPE') do set "starttype=%%S"
if "!state!"=="RUNNING" (
    set "statetxt=Running"
) else if "!state!"=="STOPPED" (
    set "statetxt=Stopped"
) else (
    set "statetxt=Unknown"
)
if "!starttype!"=="AUTO_START" (
    set "starttxt=Auto"
) else if "!starttype!"=="DEMAND_START" (
    set "starttxt=Manual"
) else if "!starttype!"=="DISABLED" (
    set "starttxt=Disabled"
) else (
    set "starttxt=Unknown"
)
echo   [!statetxt! / !starttxt!] %2
endlocal
exit /b

:disablebgapps
ECHO.
ECHO Disabling background apps and unnecessary services...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul
sc stop DiagTrack >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc stop RetailDemo >nul 2>&1
sc config RetailDemo start= disabled >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1
sc config WMPNetworkSvc start= disabled >nul 2>&1
sc stop MapsBroker >nul 2>&1
sc config MapsBroker start= disabled >nul 2>&1
sc stop Fax >nul 2>&1
sc config Fax start= disabled >nul 2>&1
sc stop RemoteRegistry >nul 2>&1
sc config RemoteRegistry start= disabled >nul 2>&1
REM sc stop SysMain >nul 2>&1
REM sc config SysMain start= disabled >nul 2>&1
ECHO Background apps and unnecessary services have been disabled.
ECHO Press any key to return to the menu...
pause >nul
goto mainmenu
