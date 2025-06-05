@echo off
setlocal enabledelayedexpansion

REM -----------------------------------------------------
REM Creates a release zip file for flexlogger plugins and the sift_proxy
REM Builds of the Sift flexlogger plugins are pulled from C:\Users\Public\Documents\National Instruments\FlexLogger\Plugins\IOPlugins
REM -----------------------------------------------------

set "TARGET_DIR=%~dp0\dist"
set "SOURCE_FILE=%~dp0..\..\src\Sift\Support\sift_proxy.exe"
echo Moving sift_proxy...

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


set "DIR_LIST="C:\Users\Public\Documents\National Instruments\FlexLogger\Plugins\IOPlugins\Sift Stream" "C:\Users\Public\Documents\National Instruments\FlexLogger\Plugins\IOPlugins\Sift TDMS Uploader""
REM This is the default Flexlogger plugin directory
echo Moving Sift Flexlogger Plug-ins...


for %%D in (%DIR_LIST%) do (
    set "FULLSRC=%%~D"

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

set "ZIP_NAME=flexlogger_dist.zip"
powershell -noprofile -command ^
  "Compress-Archive -Path '%TARGET_DIR%\*' -DestinationPath '%ZIP_NAME%' -Force" >nul
if errorlevel 1 (
    echo [ERROR] Failed to create ZIP: "%ZIP_NAME%".
    goto EndScript
) else (
    echo [OK] ZIP created successfully at "%ZIP_NAME%".
)


echo:
echo Dist zip creation complete. Press any key to continue...
pause >nul
endlocal
