@echo off
setlocal EnableDelayedExpansion

:: Check if root_folder.txt exists
if not exist "root_folder.txt" (
    echo Error: root_folder.txt not found!
    pause
    exit /b 1
)

:: Read root folder path
set /p root_folder=<root_folder.txt

:: Check if root folder exists
if not exist "%root_folder%" (
    echo Error: Root folder '%root_folder%' does not exist!
    pause
    exit /b 1
)

echo Starting repository updates...
echo Root folder: %root_folder%

for /d %%D in ("%root_folder%\*") do (
    if exist "%%D\.git" (
        echo Processing repository: %%~nxD
        
        pushd "%%D"
        
        git fetch origin > nul 2>&1
        if !errorlevel! equ 0 (
            git pull
            if !errorlevel! equ 0 (
                echo Successfully updated: %%~nxD
            ) else (
                echo Error pulling repository: %%~nxD
            )
        ) else (
            echo Error fetching repository: %%~nxD
        )
        
        popd
    ) else (
        echo Skipping non-git directory: %%~nxD
    )
)

echo.
echo Process completed.
pause
endlocal