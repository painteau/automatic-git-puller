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

:: Create logs directory
if not exist "logs" mkdir logs

:: Create log file with timestamp
set datetime=%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set datetime=%datetime: =0%
set log_file=logs\autopuller_%datetime%.log

echo [%date% %time%] Starting repository updates... >> "%log_file%"
echo [%date% %time%] Root folder: %root_folder% >> "%log_file%"

for /d %%D in ("%root_folder%\*") do (
    if exist "%%D\.git" (
        echo [%date% %time%] Processing repository: %%~nxD
        echo [%date% %time%] Processing repository: %%~nxD >> "%log_file%"
        
        pushd "%%D"
        
        git fetch origin > nul 2>&1
        if !errorlevel! equ 0 (
            git pull > "%TEMP%\pull_result.txt" 2>&1
            set /p pull_result=<"%TEMP%\pull_result.txt"
            if !errorlevel! equ 0 (
                echo [%date% %time%] Successfully updated: %%~nxD
                echo [%date% %time%] Successfully updated: %%~nxD >> "%log_file%"
                echo [%date% %time%] Pull result: !pull_result! >> "%log_file%"
            ) else (
                echo [%date% %time%] Error pulling repository: %%~nxD
                echo [%date% %time%] Error pulling repository: %%~nxD >> "%log_file%"
                type "%TEMP%\pull_result.txt" >> "%log_file%"
            )
        ) else (
            echo [%date% %time%] Error fetching repository: %%~nxD
            echo [%date% %time%] Error fetching repository: %%~nxD >> "%log_file%"
        )
        
        popd
    ) else (
        echo [%date% %time%] Skipping non-git directory: %%~nxD
        echo [%date% %time%] Skipping non-git directory: %%~nxD >> "%log_file%"
    )
)

echo [%date% %time%] Finished processing all repositories >> "%log_file%"
echo.
echo Process completed. Check the logs in: %log_file%
pause
endlocal