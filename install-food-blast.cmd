@echo off
setlocal

:: Set the source and target paths
set "cstrike_source_folder=cstrike"
set "cstrike_target_folder=C:\Program Files (x86)\Steam\steamapps\common\Half-Life\cstrike"
set "steam_images_source_folder=steam_images"
set "steam_images_target_folder=C:\Program Files (x86)\Steam\appcache\librarycache"
set "log_file=install_log.txt"
set "version_string=v1.4.1"

:: Ask the user to confirm the installation
echo ############################################
echo #      FOOD-BLAST %version_string% INSTALLATION       #
echo ############################################
echo.
echo This script will install Food-Blast on top of your existing cstrike installation.
echo Target folder: "%cstrike_target_folder%".
echo.
echo Before proceeding, please exit Steam completely.
set /p user_confirm="Do you want to proceed?  (Y/N): "

:: Check if the user pressed "Y" or "y"
if /i "%user_confirm%" neq "Y" (
    echo Installation canceled.
    echo Installation canceled. >> "%log_file%"
    goto end
)

:: Check if the target folder exists
if not exist "%cstrike_target_folder%" (
    echo Error: The target folder "%cstrike_target_folder%" does not exist.
    echo Please make sure the game is installed and the path is correct.
    echo Error: "%cstrike_target_folder%" does not exist. >> "%log_file%"
    goto end
)

:: Copy the contents of the source folder to the target folder
echo Installing Food-Blast...
echo Copying Food-Blast data to "%cstrike_target_folder%". >> "%log_file%"
xcopy "%cstrike_source_folder%\*" "%cstrike_target_folder%" /s /i /y
if %errorlevel% neq 0 (
    echo Error: Failed to copy Food-Blast files.
    echo Error: Failed to copy Food-Blast files. >> "%log_file%"
    goto end
)

:: Install foodblast config and append it to config.cfg so it's ran once on launch
type "%cstrike_source_folder%\foodblast.cfg" >> "%cstrike_target_folder%\config.cfg"

echo Installing Food-Blast images to Steam...
echo Copying Food-Blast steam images to "%steam_images_target_folder%". >> "%log_file%"
xcopy "%steam_images_source_folder%\*" "%steam_images_target_folder%" /s /i /y
if %errorlevel% neq 0 (
    echo Error: Failed to copy Food-Blast images to Steam.
    echo Error: Failed to copy Food-Blast images to Steam. >> "%log_file%"
    goto end
)

echo Food-Blast installed successfully! You may now open steam and launch the game.
echo Food-Blast installed successfully! >> "%log_file%"

:end
endlocal
pause
