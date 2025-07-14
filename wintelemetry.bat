@echo off
REM --- Force Admin Privileges ---
fsutil dirty query %systemdrive% >nul 2>&1
if errorlevel 1 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs" >nul 2>&1
    exit /b
)

setlocal enabledelayedexpansion

REM Registry keys/values for telemetry, feedback, and diagnostics
set keys[0]=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection AllowTelemetry
set keys[1]=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection AllowDeviceNameInTelemetry
set keys[2]=HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows CEIPEnable
set keys[3]=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat AITEnable
set keys[4]=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting value
set keys[5]=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection DoNotShowFeedbackNotifications
set keys[6]=HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting Disabled
set keys[7]=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat DisableInventory
set keys[8]=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat DisableTelemetry
set keys[9]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search AllowCortana
set keys[10]=HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo DisabledByGroupPolicy
set keys[11]=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableTailoredExperiencesWithDiagnosticData
set keys[12]=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowSenseHotSpots value
set keys[13]=HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots value
set keys[14]=HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors DisableLocation
set keys[15]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System PublishUserActivities
set keys[16]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System UploadUserActivities
set keys[17]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System EnableActivityFeed
set keys[18]=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced Start_TrackProgs
set keys[19]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search ConnectedSearchUseWeb
set keys[20]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search ConnectedSearchUseWebOverMeteredConnections
set keys[21]=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableWindowsSpotlightFeatures
set keys[22]=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableWindowsSpotlightOnActionCenter
set keys[23]=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableWindowsSpotlightOnSettings
set keys[24]=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent DisableWindowsSpotlightWindowsWelcomeExperience
set keys[25]=HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy LetAppsRunInBackground
set keys[26]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System EnableActivityFeed
set keys[27]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System PublishUserActivities
set keys[28]=HKLM\SOFTWARE\Policies\Microsoft\Windows\System UploadUserActivities
set keys[29]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Feedback DisableFeedbackNotifications
set keys[30]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Feedback NumberOfSIUFInPeriod
set keys[31]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Feedback PeriodInNanoSeconds
@REM set keys[32]=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection MaxTelemetryAllowed
@REM set keys[33]=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack Enabled
@REM set keys[34]=HKLM\SOFTWARE\Policies\Microsoft\Windows\Privacy DisablePrivacyExperience
@REM set keys[35]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting Disabled
@REM set keys[36]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting ForceQueue
@REM set keys[37]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting DoReport
@REM set keys[38]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendAllData
@REM set keys[39]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendAdditionalData
@REM set keys[40]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendSafeReports
@REM set keys[41]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendWatsonReport
@REM set keys[42]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendQueueReports
@REM set keys[43]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendUserReports
@REM set keys[44]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendUserReportsConsent
@REM set keys[45]=HKLM\SOFTWARE\Policies\Microsoft\Windows\ErrorReporting SendUserReportsNoConsent

set desc[0]=Data Collection
set desc[1]=Device Name in Telemetry
set desc[2]=Customer Experience Improvement
set desc[3]=Application Telemetry
set desc[4]=WiFi HotSpot Reporting
set desc[5]=Feedback Notifications
set desc[6]=Error Reporting
set desc[7]=Inventory Collector
set desc[8]=AppCompat Telemetry
set desc[9]=Cortana
set desc[10]=Advertising ID
set desc[11]=Tailored Experiences
set desc[12]=WiFi Sense HotSpots
set desc[13]=WiFi Sense AutoConnect
set desc[14]=Location Tracking
set desc[15]=Activity History
set desc[16]=Activity History Upload
set desc[17]=Timeline
set desc[18]=App Launch Tracking
set desc[19]=Search Online
set desc[20]=Search Web Over Metered
set desc[21]=Spotlight Features
set desc[22]=Spotlight Action Center
set desc[23]=Spotlight Settings
set desc[24]=Spotlight Welcome Experience
set desc[25]=Background Apps
set desc[26]=Activity Feed (System)
set desc[27]=Publish User Activities (System)
set desc[28]=Upload User Activities (System)
set desc[29]=Disable Feedback Notifications
set desc[30]=Feedback SIUF Count
set desc[31]=Feedback Period
@REM set desc[32]=Max Telemetry Allowed
@REM set desc[33]=Diagnostics Tracking
@REM set desc[34]=Disable Privacy Experience
@REM set desc[35]=Error Reporting Disabled
@REM set desc[36]=Error Reporting ForceQueue
@REM set desc[37]=Error Reporting DoReport
@REM set desc[38]=Error Reporting SendAllData
@REM set desc[39]=Error Reporting SendAdditionalData
@REM set desc[40]=Error Reporting SendSafeReports
@REM set desc[41]=Error Reporting SendWatsonReport
@REM set desc[42]=Error Reporting SendQueueReports
@REM set desc[43]=Error Reporting SendUserReports
@REM set desc[44]=Error Reporting SendUserReportsConsent
@REM set desc[45]=Error Reporting SendUserReportsNoConsent

:mainmenu
cls
echo ===============================
echo   DEBLOAT WINDOWS
echo ===============================

echo.
echo Telemetry Status:
for /L %%i in (0,1,45) do (
    for /f "tokens=1,2" %%a in ("!keys[%%i]!") do (
        set "k=%%a"
        set "v=%%b"
        for /f "tokens=3" %%V in ('reg query !k! /v !v! 2^>nul') do (
            if "%%V"=="0x0" (
                echo   [Disabled] !desc[%%i]!
            ) else (
                echo   [Enabled]  !desc[%%i]!
            )
            set found=1
        )
        if not defined found echo   [Not Set] !desc[%%i]!
        set found=
    )
)

echo.
REM Robust OneDrive status check
set "ODStatus=Enabled"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" 2>nul | find "0x1" >nul && set "ODStatus=Disabled by Policy"
if "%ODStatus%"=="Enabled" (
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive 2>nul | find /i "OneDrive.exe" >nul || set "ODStatus=Disabled: Not set to run"
)
echo OneDrive Status: [%ODStatus%]

echo.
echo [1] Disable ALL telemetry
echo [2] Enable ALL telemetry
echo [3] Disable and block OneDrive
echo [4] Enable and unblock OneDrive
echo [5] Uninstall OneDrive
echo [6] Disable background apps/services
echo    (DiagTrack dmwappushservice RetailDemo WMPNetworkSvc MapsBroker Fax RemoteRegistry)
echo [Q] Quit
set /p choice=Choose option: 
if "%choice%"=="1" goto disableall
if "%choice%"=="2" goto enableall
if "%choice%"=="3" goto disableonedrive
if "%choice%"=="4" goto enableonedrive
if "%choice%"=="5" goto uninstallonedrive
if "%choice%"=="6" goto disablebgapps
if /i "%choice%"=="Q" exit
echo Wrong option. Press any key.
pause >nul
goto mainmenu

:disableall
echo Disabling all telemetry...
for /L %%i in (0,1,45) do (
    for /f "tokens=1,2" %%a in ("!keys[%%i]!") do reg add "%%a" /v %%b /t REG_DWORD /d 0 /f >nul
)
echo Done. Press any key.
pause >nul
goto mainmenu

:enableall
echo Enabling all telemetry...
REM Only enable crucial system keys (error reporting), disable others
for /L %%i in (0,1,45) do (
    set enable=0
    if %%i geq 35 if %%i leq 45 set enable=1
    for /f "tokens=1,2" %%a in ("!keys[%%i]!") do reg add "%%a" /v %%b /t REG_DWORD /d !enable! /f >nul
)
echo Done. Press any key.
pause >nul
goto mainmenu

:disableonedrive
echo Disabling OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
sc query OneDrive >nul 2>&1 && (
    sc stop OneDrive >nul 2>&1
    sc config OneDrive start= disabled >nul 2>&1
)
echo Done. Press any key.
pause >nul
goto mainmenu

:enableonedrive
echo Enabling OneDrive...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "%SystemRoot%\System32\OneDrive.exe /background" /f >nul
sc query OneDrive >nul 2>&1 && sc config OneDrive start= demand >nul 2>&1
echo Done. Press any key.
pause >nul
goto mainmenu

:uninstallonedrive
echo Uninstalling OneDrive...
TASKKILL /F /IM OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
)
rd /s /q "%UserProfile%\OneDrive" >nul 2>&1
rd /s /q "%LocalAppData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%ProgramData%\Microsoft\OneDrive" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
echo Done. Press any key.
pause >nul
goto mainmenu

:disablebgapps
echo Disabling background apps/services...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 2 /f >nul
for %%S in (DiagTrack dmwappushservice RetailDemo WMPNetworkSvc MapsBroker Fax RemoteRegistry) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)
echo disabled services:
for %%S in (DiagTrack dmwappushservice RetailDemo WMPNetworkSvc MapsBroker Fax RemoteRegistry) do (
    echo   %%S
)
echo Done. Press any key.
pause >nul
goto mainmenu

:blockspotlight
echo Blocking Windows Spotlight...
for %%K in (DisableWindowsSpotlightFeatures DisableWindowsSpotlightOnActionCenter DisableWindowsSpotlightOnSettings DisableWindowsSpotlightWindowsWelcomeExperience) do (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v %%K /t REG_DWORD /d 1 /f >nul
    reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v %%K /t REG_DWORD /d 1 /f >nul
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul
set "SPOTDIR=%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy"
if exist "%SPOTDIR%" (
    takeown /f "%SPOTDIR%" /r /d y >nul 2>&1
    icacls "%SPOTDIR%" /inheritance:r /deny SYSTEM:(OI)(CI)F BUILTIN\Users:(OI)(CI)F BUILTIN\Administrators:(OI)(CI)F >nul 2>&1
    rd /s /q "%SPOTDIR%" >nul 2>&1
)
findstr /i "arc.msn.com" %SystemRoot%\System32\drivers\etc\hosts >nul || echo 0.0.0.0 arc.msn.com >> %SystemRoot%\System32\drivers\etc\hosts
findstr /i "assets.msn.com" %SystemRoot%\System32\drivers\etc\hosts >nul || echo 0.0.0.0 assets.msn.com >> %SystemRoot%\System32\drivers\etc\hosts
echo Done. Press any key.
pause >nul
goto mainmenu
