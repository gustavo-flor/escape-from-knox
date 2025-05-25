setlocal EnableDelayedExpansion

if "%~1"=="" (
    echo "Error: Path to Zomboid's folder is required."
    echo "Usage: $0 <path-to-zomboid-folder>"
    exit /b 1
)

set zomboidFolder="%~1"

set modPath[0]=escape-from-knox-first-aids
set modName[0]=EFKFirstAids
set modPath[1]=escape-from-knox-injectors
set modName[1]=EFKInjectors
set modPath[2]=escape-from-knox-health-system
set modName[2]=EFKHealthSystem
set modPath[3]=escape-from-knox-extraction-mode
set modName[3]=EFKExtractionMode
set modsCount=4

for /L %%i in (0,1,%modsCount%-1) do (
    rmdir "%zomboidFolder%/mods/!modName[%%i]!" 2>nul
    rmdir "%zomboidFolder%/Workshop/!modPath[%%i]!" 2>nul
)

endlocal 