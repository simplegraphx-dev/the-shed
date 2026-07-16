
@echo off
title Update The Shed
color 0A

echo.
echo  ================================
echo    THE SHED - Auto Updater
echo  ================================
echo.

set REPO=C:\Users\simpl\OneDrive\Documents\GitHub\the-shed
set DOWNLOADS=%USERPROFILE%\Downloads

:: Find the most recently modified index*.html in Downloads
set LATEST=
for /f "delims=" %%f in ('dir /b /o-d "%DOWNLOADS%\index*.html" 2^>nul') do (
    if not defined LATEST set LATEST=%%f
)

if not defined LATEST (
    echo  ERROR: Could not find any index.html file in Downloads.
    echo.
    echo  File must start with index and end with .html
    echo  e.g. index.html, index_1.html, index_2.html
    echo.
    pause
    exit
)

echo  Found: %LATEST%
echo  Copying to repository...
copy /Y "%DOWNLOADS%\%LATEST%" "%REPO%\index.html" >nul
echo  Done!
echo.

cd /d "%REPO%"

where git >nul 2>&1
if errorlevel 1 (
    echo  ERROR: Git not found. Install from https://git-scm.com
    pause
    exit
)

echo  Committing...
git add index.html >nul 2>&1
git commit -m "Update The Shed app" >nul 2>&1
echo  Done!
echo.

echo  Pushing to GitHub...
git push >nul 2>&1
echo  Done!
echo.

echo  ================================
echo   SUCCESS! Live in ~60 seconds at:
echo   simplegraphx.github.io/the-shed
echo  ================================
echo.

pause