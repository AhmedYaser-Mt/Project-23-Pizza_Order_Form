@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Universal Git Upload Tool

echo =========================================
echo        Universal Git Upload Tool
echo =========================================
echo.

:: -------------------------------------------------
:: 1) Ensure Git repository exists
:: -------------------------------------------------
if not exist ".git" (
    echo No Git repository found.
    echo Initializing a new repository...
    git init
    if errorlevel 1 (
        echo Failed to initialize Git repository.
        pause
        exit /b 1
    )
)

:: -------------------------------------------------
:: 2) Force branch to main
:: -------------------------------------------------
set "currentBranch=main"

git checkout main >nul 2>nul
if errorlevel 1 (
    git checkout -b main >nul 2>nul
)

echo Using branch: !currentBranch!
echo.

:: -------------------------------------------------
:: 3) Ensure .gitignore exists (for C# / VS projects)
:: -------------------------------------------------
if not exist ".gitignore" (
    echo Creating .gitignore for Visual Studio projects...
    (
        echo # Build results
        echo bin/
        echo obj/
        echo
        echo # User-specific files
        echo *.user
        echo *.suo
        echo *.cache
        echo
        echo # Executables
        echo *.exe
        echo *.dll
    ) > .gitignore
)

:: -------------------------------------------------
:: 4) Show repository status
:: -------------------------------------------------
echo Repository status:
git status
echo.

:: -------------------------------------------------
:: 5) Add files and show staged files
:: -------------------------------------------------
echo Adding files...
git add .
if errorlevel 1 (
    echo Failed to stage files.
    pause
    exit /b 1
)

echo.
echo Staged files:
git diff --cached --name-only
echo.

git diff --cached --quiet
if errorlevel 1 (
    set "commitMsg="
    set /p "commitMsg=Enter commit message: "
    if not defined commitMsg (
        echo Commit message cannot be empty.
        pause
        exit /b 1
    )

    git commit -m "!commitMsg!"
    if errorlevel 1 (
        echo Commit failed.
        pause
        exit /b 1
    )
) else (
    echo Nothing new to commit.
)

:: -------------------------------------------------
:: 6) Ask for GitHub repository URL (every time)
:: -------------------------------------------------
set "repoURL="
set /p "repoURL=Enter GitHub repository URL: "
if not defined repoURL (
    echo Repository URL cannot be empty.
    pause
    exit /b 1
)

:: -------------------------------------------------
:: 7) Check internet connection
:: -------------------------------------------------
echo.
echo Checking internet connection...
ping github.com -n 1 >nul
if errorlevel 1 (
    echo No internet connection detected.
    pause
    exit /b 1
)
echo Internet connection OK.
echo.

:: -------------------------------------------------
:: 8) Configure remote safely
:: -------------------------------------------------
git remote remove origin >nul 2>nul
git remote add origin "!repoURL!"
if errorlevel 1 (
    echo Failed to set remote origin.
    pause
    exit /b 1
)

:: -------------------------------------------------
:: 9) Handle README conflict if exists remotely
:: -------------------------------------------------
echo Checking for README conflicts...
git pull origin main --allow-unrelated-histories --no-edit >nul 2>nul

:: -------------------------------------------------
:: 10) Push to GitHub (main only)
:: -------------------------------------------------
echo Pushing to remote (main)...
git push -u origin main --force-with-lease

if errorlevel 1 (
    echo.
    echo Push failed. Trying normal push...
    git push -u origin main
    if errorlevel 1 (
        echo Push failed again.
        pause
        exit /b 1
    )
)

echo.
echo Done successfully.
pause
exit /b 0
