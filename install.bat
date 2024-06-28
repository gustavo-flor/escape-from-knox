setlocal

if "%~1"=="" (
    echo "Error: Path to Zomboid's mods folder is required."
    echo "Usage: $0 <path-to-zomboid-mods-folder>"
    exit /b 1
)

set zomboidFolder="%~1"

for %%i in (".\") do set efkHome="%%~fi"

mklink /J "%zomboidFolder%/mods/EFKFirstAids" "%efkHome%escape-from-knox-first-aids/Contents/mods/EFKFirstAids"
mklink /J "%zomboidFolder%/mods/EFKInjectors" "%efkHome%escape-from-knox-injectors/Contents/mods/EFKInjectors"
mklink /J "%zomboidFolder%/mods/EFKHealthSystem" "%efkHome%escape-from-knox-health-system/Contents/mods/EFKHealthSystem"

mklink /J "%zomboidFolder%/Workshop/escape-from-knox-first-aids" "%efkHome%escape-from-knox-first-aids"
mklink /J "%zomboidFolder%/Workshop/escape-from-knox-injectors" "%efkHome%escape-from-knox-injectors"
mklink /J "%zomboidFolder%/Workshop/escape-from-knox-health-system" "%efkHome%escape-from-knox-health-system"

endlocal