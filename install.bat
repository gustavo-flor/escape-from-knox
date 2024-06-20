setlocal

if "%~1"=="" (
    echo "Error: Path to Zomboid's mods folder is required."
    echo "Usage: $0 <path-to-zomboid-mods-folder>"
    exit /b 1
)

set zomboidModsFolder="%~1"

for %%i in (".\") do set efkHome="%%~fi"

mklink /J "%zomboidModsFolder%escape-from-knox-first-aids" "%efkHome%escape-from-knox-first-aids"
mklink /J "%zomboidModsFolder%escape-from-knox-injectors" "%efkHome%escape-from-knox-injectors"
mklink /J "%zomboidModsFolder%escape-from-knox-health-system" "%efkHome%escape-from-knox-health-system"

endlocal