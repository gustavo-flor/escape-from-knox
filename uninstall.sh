#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Path to Zomboid's folder is required."
    echo "Usage: $0 <path-to-zomboid-folder>"
    exit 1
fi

ZOMBOID_MODS_FOLDER="$1/mods"
ZOMBOID_WORKSHOP_FOLDER="$1/Workshop"

declare -A MODS=(
    ["escape-from-knox-first-aids"]="EFKFirstAids"
    ["escape-from-knox-injectors"]="EFKInjectors"
    ["escape-from-knox-health-system"]="EFKHealthSystem"
    ["escape-from-knox-extraction-mode"]="EFKExtractionMode"
)

for mod_path in "${!MODS[@]}"; do
    mod_name="${MODS[$mod_path]}"
    
    rm -rf "$ZOMBOID_MODS_FOLDER/$mod_name"
    rm -rf "$ZOMBOID_WORKSHOP_FOLDER/$mod_path"
done 