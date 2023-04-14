@echo off
setlocal EnableDelayedExpansion

set /p root_folder=<root_folder.txt

for /d %%D in ("%root_folder%\*") do (
  echo Traitement du dossier %%~nxD...
  pushd "%%D"
  git pull
  popd
)

endlocal
pause