#!/usr/bin/env bash

export supermode="gum"
export remote_git="https://github.com/schombert/Project-Alice.git"
export project_alice="$HOME/Project-Alice"
export alice_app="$HOME/Project-Alice/build/AliceIncremental"
export alice_assets="$HOME/Project-Alice/assets"
export base_game="/game/v2"
export CC="/usr/bin/clang"
export CXX="/usr/bin/clang++"
# shellcheck disable=SC1091
source ./easybashgui

menu "Install Game" "Update Game" "Launch Game"
# shellcheck disable=SC2154
choice="$(0<"${dir_tmp}/${file_tmp}")"

if [ "${choice}" = "Install Game" ]; then
    git clone --depth 1 $remote_git || alert_message "PA repository already exists!" && exit
    # shellcheck disable=SC2164
    cd "$project_alice"
    cmake -B build . -DCMAKE_BUILD_TYPE=Release
    cmake --build build -j "$(nproc)" -t AliceIncremental

    if [ -d $base_game ]; then
        cp -r "$alice_assets" $base_game
        cp "$alice_app" $base_game
        message "Project Alice installed!"
    else
        alert_message "ERROR: Could not detect base game. Is the volume mounted correctly?"
    fi
elif [ "${choice}" = "Update Game" ]; then
    cd "$project_alice" || exit
    git pull
    cmake -B build . -DCMAKE_BUILD_TYPE=Release
    cmake --build build -j "$(nproc)" -t AliceIncremental

    if [ -d $base_game ]; then
        # cp always replaces old files
        cp -r "$alice_assets" $base_game
        cp "$alice_app" $base_game
        message "Project Alice updated!"
    else
        alert_message "ERROR: Could not detect base game. Is the volume mounted correctly?"
    fi
elif [ "${choice}" = "Launch Game" ]; then
    cd $base_game || exit
    ls -- mod/*.mod >mod/mods.txt
    mapfile mods <mod/mods.txt
    menu "Vanilla" "${mods[@]}"
    mod_check="$(0<"${dir_tmp}/${file_tmp}")"

    if [ "${mod_check}" = "Vanilla" ]; then
        ./AliceIncremental
    else
        ./AliceIncremental --mod "$mod_check"
    fi
else
    exit
fi
