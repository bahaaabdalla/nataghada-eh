@echo off
setlocal
cd /d "%~dp0"
title Deploy Nataghada Eh to Vercel

echo.
echo ===============================================
echo Deploying nataghada-eh to Vercel Production
echo ===============================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js is not installed or not available in PATH.
  echo Install Node.js LTS, then run this file again.
  echo https://nodejs.org/
  echo.
  pause
  exit /b 1
)

where npx >nul 2>&1
if errorlevel 1 (
  echo ERROR: npx is not available in PATH.
  echo Reinstall Node.js LTS, then restart Windows.
  echo.
  pause
  exit /b 1
)

echo Node version:
node --version
echo npm version:
npm --version
echo.

echo Step 1 of 3: Sign in to Vercel...
call npx --yes vercel@latest login
if errorlevel 1 goto fail

echo.
echo Step 2 of 3: Link to the existing Vercel project...
call npx --yes vercel@latest link --yes --project nataghada-eh --scope bahaaabdallas-projects
if errorlevel 1 goto fail

echo.
echo Step 3 of 3: Deploy to Production...
call npx --yes vercel@latest deploy --prod --yes --force
if errorlevel 1 goto fail

echo.
echo ===============================================
echo DEPLOYMENT COMPLETED
echo https://nataghada-eh.vercel.app
echo ===============================================
echo.
pause
exit /b 0

:fail
echo.
echo DEPLOYMENT FAILED.
echo Take a screenshot of this window and send it in ChatGPT.
echo.
pause
exit /b 1
