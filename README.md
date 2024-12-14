# Project Alice Distrobox
I created this so I could play PA on any distro I wanted without needing to sweat the details. It uses Distrobox to assemble a containerized Arch Linux installation with all the packages necessary to build & play the game, plus automating most of the handiwork via `setup.elv`. 

## The Details

NVIDIA USERS ONLY: Open `distrobox.ini` then switch `nvidia` to `true`

1. Install [Podman](https://podman.io/) and [Distrobox](https://distrobox.it/).
2. `chmod +x pre-setup.sh && ./pre-setup.sh` to prepare your copy of V2 (Note: If your Victoria 2 isn't through Steam, this won't work. Manually copy it here and rename it `v2`).
3. `distrobox assemble create` to prepare the Arch container.
4. `distrobox enter arch` to open the container's terminal.
5. `cd && chmod +x setup.elv && ./setup.elv` to compile and install Project Alice into your V2 copy.

By default, the setup script compiles the release version, which may take a few hours to complete depending on your CPU specs. After that, it's smooth sailing—anytime you want to game, simply enter the container as in step #4 and run `launch.elv`.