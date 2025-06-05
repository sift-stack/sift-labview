@echo off
setlocal enabledelayedexpansion

REM -----------------------------------------------------
REM Installer for sift_proxy
REM -----------------------------------------------------

set "TARGET_DIR=%LOCALAPPDATA%\Sift"
set "SOURCE_FILE=%~dp0sift_proxy.exe"
echo Installing sift_proxy...

for %%I in ("%SOURCE_FILE%") do set "FILENAME=%%~nxI"

if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
)

REM Overwrites sift_proxy if it exists
copy /Y "%SOURCE_FILE%" "%TARGET_DIR%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to copy "%FILENAME%" to "%TARGET_DIR%".
) else (
    echo [OK] Successfully copied "%FILENAME%" to "%TARGET_DIR%".
)
echo:

REM -----------------------------------------------------
REM Installer for Flexlogger plugins
REM -----------------------------------------------------
set "DIR_LIST="Sift Stream" "Sift TDMS Uploader""
REM This is the default Flexlogger plugin directory
set "TARGET_DIR=C:\Users\Public\Documents\National Instruments\FlexLogger\Plugins\IOPlugins
echo Installing Sift Flexlogger Plug-ins...


for %%D in (%DIR_LIST%) do (
    set "SRC=%%~D"
    set "FULLSRC=%~dp0!SRC!"

    REM Verify that the folder actually exists
    if not exist "!FULLSRC!\" (
        echo [ERROR] Source folder not found: "!FULLSRC!"
    ) else (
        for %%N in ("!FULLSRC!") do set "DIR_NAME=%%~nxN"

        REM Build the destination folder under %TARGET_DIR%
        set "DEST_DIR=%TARGET_DIR%\!DIR_NAME!"

        REM Recursively copy everything from FULLSRC → DEST_DIR
        xcopy "!FULLSRC!" "!DEST_DIR!\" /E /I /Y >nul
        if errorlevel 1 (
            echo [ERROR] Failed to copy folder "!FULLSRC!" to "!DEST_DIR!".
        ) else (
            echo [OK] Successfully copied "!FULLSRC!" to "!DEST_DIR!".
        )
    )
)
echo:
echo Install complete. Press any key to continue...
pause >nul
endlocal
