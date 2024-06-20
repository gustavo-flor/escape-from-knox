#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: Path to Zomboid's mods folder is required."
    echo "Usage: $0 <path-to-zomboid-mods-folder>"
    exit 1
fi

ZOMBOID_MODS_FOLDER="$1"
EFK_HOME="$(cd "$(dirname "$0")" && pwd)"

mkdir "$ZOMBOID_MODS_FOLDER/escape-from-knox-first-aids"
ln -s "$EFK_HOME/escape-from-knox-first-aids" "$ZOMBOID_MODS_FOLDER/escape-from-knox-first-aids"

mkdir "$ZOMBOID_MODS_FOLDER/escape-from-knox-injectors"
ln -s "$EFK_HOME/escape-from-knox-injectors" "$ZOMBOID_MODS_FOLDER/escape-from-knox-injectors"

mkdir "$ZOMBOID_MODS_FOLDER/escape-from-knox-health-system"
ln -s "$EFK_HOME/escape-from-knox-health-system" "$ZOMBOID_MODS_FOLDER/escape-from-knox-health-system"
