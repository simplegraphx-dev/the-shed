@echo off
title Update My Apps
color 0A

:MENU
cls
echo  ================================
echo    MY APPS - Auto Updater
echo  ================================
echo.
echo   1. The Shed (Garage Log)
echo   2. Vitals Ledger
echo   3. Shopping Cart (Cart Ledger)
echo   4. All three
echo   5. Exit
echo.
set /p CHOICE="Choose an option (1-5): "

if "%CHOICE%"=="1" call :UpdateApp "The Shed" "C:\Users\simpl\OneDrive\Documents\GitHub\the-shed" "index*.html" "index.html" "simplegraphx.github.io/the-shed"
if "%CHOICE%"=="2" call :UpdateApp "Vitals Ledger" "C:\Users\simpl\OneDrive\Documents\GitHub\Vitals-Ledger" "vitals-ledger*.html" "index.html" "simplegraphx-dev.github.io/Vitals-Ledger"
if "%CHOICE%"=="3" call :UpdateApp "Shopping Cart" "C:\Users\simpl\OneDrive\Documents\GitHub\Cart-Ledger" "cart-ledger*.html" "index.html" "simplegraphx-dev.github.io/Cart-Ledger"
if "%CHOICE%"=="4" (
    call :UpdateApp "The Shed" "C:\Users\simpl\OneDrive\Documents\GitHub\the-shed" "index*.html" "index.html" "simplegraphx.github.io/the-shed"
    call :UpdateApp "Vitals Ledger" "C:\Users\simpl\OneDrive\Documents\GitHub\Vitals-Ledger" "vitals-ledger*.html" "index.html" "simplegraphx-dev.github.io/Vitals-Ledger"
    call :UpdateApp "Shopping Cart" "C:\Users\simpl\OneDrive\Documents\GitHub\Cart-Ledger" "cart-ledger*.html" "index.html" "simplegraphx-dev.github.io/Cart-Ledger"
)
if "%CHOICE%"=="5" exit

echo.
pause
goto MENU

:UpdateApp
setlocal
set APPNAME=%~1
set REPO=%~2
set PATTERN=%~3
set TARGET=%~4
set PAGESURL=%~5
set DOWNLOADS=%USERPROFILE%\Downloads

echo.
echo  ---- Updating %APPNAME% ----

set LATEST=
for /f "delims=" %%f in ('dir /b /o-d "%DOWNLOADS%\%PATTERN%" 2^>nul') do (
    if not defined LATEST set LATEST=%%f
)
if not defined LATEST (
    echo  ERROR: Could not find any %PATTERN% file in Downloads for %APPNAME%.
    echo  Skipping...
    endlocal
    goto :eof
)
echo  Found: %LATEST%
echo  Copying to repository...
copy /Y "%DOWNLOADS%\%LATEST%" "%REPO%\%TARGET%" >nul

cd /d "%REPO%"
where git >nul 2>&1
if errorlevel 1 (
    echo  ERROR: Git not found. Install from https://git-scm.com
    endlocal
    goto :eof
)
echo  Committing and pushing...
git add "%TARGET%" >nul 2>&1
git commit -m "Update %APPNAME%" >nul 2>&1
git push >nul 2>&1
echo  Done! Live in ~60 seconds at:
echo  %PAGESURL%

endlocal
goto :eof