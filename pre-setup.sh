#!/usr/bin/bash

if [ -d "$HOME/.steam/steam/steamapps/common/Victoria 2" ]; then
    echo "Copying Victoria 2 directory..."
    cp -r "$HOME/.steam/steam/steamapps/common/Victoria 2" ./v2
elif [ -d "$HOME/.local/share/Steam/steamapps/common/Victoria 2" ]; then
    echo "Copying Victoria 2 directory..."
    cp -r "$HOME/.local/share/Steam/steamapps/common/Victoria 2" ./v2
else
    echo "ERROR: Could not autodetect Victoria 2."
fi
