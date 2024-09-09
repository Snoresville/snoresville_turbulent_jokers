# Snoresville's Turbulent Jokers

they are good jokers

## Overview

-   22 Jokers (10 Common, 7 Uncommon, 4 Rare, 1 Legendary)
-   7 Decks that revolve around some of the Jokers

[Preview the mod in this repo's website](https://snoresville.github.io/snoresville_turbulent_jokers/)

## Credits

-   notmario for the website template
-   Balatro modding community for their wealth of knowledge
-   Online stuff that I traced/inserted into the Joker art because I'm honestly not good at art
-   You, if you played the game with this mod

## How to install this mod

0. This is a Steamodded mod, [install it](https://github.com/Steamopollys/Steamodded/blob/main/README.md#how-to-install-steamodded) if you don't have it yet.
1. Get the latest from the Releases (can be seen on the right side of this webpage)
2. Unzip the folder into %appdata%/Balatro/Mods (Create Mods folder if it doesn't exist)
3. Enjoy (or not if the mod isn't installed)

## How to use this repo as a developer

This repository relies on scripts and symlinks to achieve fast and convenient updates. I (Snoresville) can attest to the time saved when making minor changes by not renaming the joker art and manually throwing them into the asset folders, both 2x and 1x.

install_mod_folder_windows.py tosses SnoresvilleTurbulentJokers into Balatro's mod folder and creates a link back to this repo for Git tracking and convenient reference.

link_sprites.py and its brethren establish symlinks from the aseprite folder to the mod folder, allowing changes to art to be reflected instantly.

Make sure to run the scripts in Administrator mode or its equivalent or some functionality will be denied. Don't worry about the programs doing anything dodgy, they run agnostically to any typical computer setup and mostly relies on variables instead of set paths.
