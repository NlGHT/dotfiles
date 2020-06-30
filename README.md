# Night's Dotfiles!

## What I got
- Bulk file editing with scripts written in C++ **(WIP: Currently renameAllHere does support large datasets, others don't.  It will all be combined and optimised in the near future!)**
    - Prefix all in current directory
        - Names can contain anything (Be a little bit careful here.....)
        - Spaces will be joined
        - Optional --silent flag for peace and quiet
        - Use example: `$ prefixAllHere [--silent] {New prefix for all files}`
    - Suffix all in current directory
        - Names can contain anything (Be a little bit careful here.....)
        - Spaces will be joined
        - Optional --silent flag for peace and quiet
        - Puts name before file extension
        - Use example: `$ suffixAllHere [--silent] {New suffix for all files}`
    - Rename all in current directory
        - Names can contain anything (Be a little bit careful here.....)
        - Spaces will be joined
        - Optional --silent flag for peace and quiet
        - Puts name before any file extension
        - Use example: `$ renameAllHere [--silent] {New name for files}`
- Some nice aliases :)
    - Terminal weather
    - Minimum brightness command
    - Currency conversion (Requires `libqalculate`)
        - Example use: `$ cconv 10 EUR USD`
- A nice .vimrc that uses YouCompleteMe (not clean yet but will be soon when I figure out how to use Unity with Vim)
    - Plugged (for plugins)
    - YouCompleteMe (for auto-complete)
    - NERDTree (for file browser)
    - NERDCommenter (for commenting with code)
    - Lightline (for nicer UI)
    - Running and building hotkeys (C++, Python, Shell)
    - Trailing white-space stripping on write

## Dependencies
Please visit the [original dependency description](https://github.com/manilarome/the-glorious-dotfiles/wiki/Dependencies) because it's done very well.  However, the base required dependencies are but you kinda need the optional ones as described over on the origin:

#### Base
| Name | Description | Why/Where is it needed? |
| --- | --- | --- |
| [`awesome-git`](https://github.com/awesomeWM/awesome) |  Highly configurable framework window manager | isn't it obvious? |
| [`rofi-git`](https://github.com/davatorium/rofi) | Window switcher, application launcher and dmenu replacement | Application launcher |
| [`tryone144's picom`](https://github.com/tryone144/compton/tree/feature/dual_kawase) | A compositor for X11 | a compositor with kawase-blur |

In addition to this the apps described below in the applications section are used in the config.  The GTK themeing is optional of course but if you don't know what you're doing then just get the things listed :).  Also however there are a few extra dependencies I use:

#### Personal Additions
| Name | Description | Why/Where is it needed? |
| --- | --- | --- |
| [`playerctl`](https://github.com/altdesktop/playerctl) | Tool for media players to play, next, previous etc. | Spotify *pause*, *play*, *next*, and *previous* keys|


## Operating system
**Arch Linux**
*(However, I am trying to keep shell scripts POSIX-compliant)*

## Apps
- Terminal: **Alacritty**
- File manager: **Nautilus**
- Web browser: **Brave**
- Text editor: **NeoVim / Vim**
- Screenshot tool: **Flameshot**

## GTK Theme
- Theme: **Matcha Dark Sea**
- Icons: **Papirus Dark**
- Font: **Gadugi Regular**
- Cursor: **Adwaita**
- Terminal font: **Input Mono**

## Creditses
The original supplier for the Awesome Window Manager config is Gerome Matilla (manilarome) who published a fantastic config that I have hacked and modified a little for my own personal preference.  Any questions or for proper installation and use (getting the right core dependencies), please visit his repository at <https://github.com/manilarome/the-glorious-dotfiles>.

He has made a great wiki for many questions that you might have and issues with setting up (including dependencies) [over here](https://github.com/manilarome/the-glorious-dotfiles/wiki).

## Disclaimer
- This is very much still a work in progress and it will be properly up and running soon!  Just wanted to get all the main files up.  *Mostly for my own well-being so that it's backed up...*
- The base Awesome config is all all Gerome Matilla's as referenced in the credits.  Hence, the license is just the same as the one he used.  **Please correct me if this is not meant to be how it is!**
