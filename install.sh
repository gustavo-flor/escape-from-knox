#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Path to Zomboid's mods folder is required."
    echo "Usage: $0 <path-to-zomboid-mods-folder>"
    exit 1
fi

ZOMBOID_MODS_FOLDER="$1/mods"
ZOMBOID_WORKSHOP_FOLDER="$1/Workshop"
EFK_HOME="$(cd "$(dirname "$0")" && pwd)"

mkdir "$ZOMBOID_MODS_FOLDER/EFKFirstAids"
ln -s "$EFK_HOME/escape-from-knox-first-aids/Contents/mods/EFKFirstAids" "$ZOMBOID_MODS_FOLDER/EFKFirstAids"
mkdir "$ZOMBOID_MODS_FOLDER/EFKInjectors"
ln -s "$EFK_HOME/escape-from-knox-injectors/Contents/mods/EFKInjectors" "$ZOMBOID_MODS_FOLDER/EFKInjectors"
mkdir "$ZOMBOID_MODS_FOLDER/EFKHealthSystem"
ln -s "$EFK_HOME/escape-from-knox-health-system/Contents/mods/EFKHealthSystem" "$ZOMBOID_MODS_FOLDER/EFKHealthSystem"

mkdir "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-first-aids"
ln -s "$EFK_HOME/escape-from-knox-first-aids" "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-first-aids"
mkdir "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-injectors"
ln -s "$EFK_HOME/escape-from-knox-injectors" "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-injectors"
mkdir "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-health-system"
ln -s "$EFK_HOME/escape-from-knox-health-system" "$ZOMBOID_WORKSHOP_FOLDER/escape-from-knox-health-system"
