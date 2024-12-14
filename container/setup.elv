#!/usr/bin/elvish

var project_alice = ~/Project-Alice
var remote_git = "https://github.com/schombert/Project-Alice.git"
var alice_app = ~/Project-Alice/build/AliceIncremental
var alice_assets = ~/Project-Alice/assets
var base_game = /game/v2
set E:CC = /usr/bin/clang
set E:CXX = /usr/bin/clang++

git clone --depth 1 $remote_git; cd $project_alice; cmake -B build . -DCMAKE_BUILD_TYPE=Release; cmake --build build -j (nproc) -t AliceIncremental

if ?(test -d $base_game) {
    cp -r $alice_assets $base_game
    cp $alice_app $base_game
    echo "Project Alice installed! You can start the game from launch.elv"
} else {
    echo "ERROR: Could not detect base game. Is the volume mounted correctly?"
}