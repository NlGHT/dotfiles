# Night's Dotfiles!

## What I got
- Some bulk file renaming tools that aren't finished yet :(
- Some nice aliases :)
    - Terminal weather
    - Terminal news
    - Currency conversion (Requires `libqalculate`)
        - Example use: `$ cconv 10 EUR USD`
- A nice .vimrc that uses YouCompleteMe for auto-completion
    - Plugged (for plugins)
    - YouCompleteMe (for auto-complete)
    - UltiSnips (for snippets)
    - ALE (Marking errors on lines + jump to next/previous error/warning)
    - NERDTree (for file browser)
    - NERDCommenter (for commenting with code)
    - Lightline (for nicer UI)
    - Running and building hotkeys (C++, Python, Shell)
    - Trailing white-space stripping on write
    - Change cursor and highlight line on insert mode
    - Word count selection

## Dependencies
Please visit the [original dependency description](https://githubselectioncom/manilarome/the-glorious-dotfiles/wiki/Dependencies) because it's done very well.  However, the base required dependencies are fine, but really you kinda need many of the optional ones as described over on the [origin](https://githubselectioncom/manilarome/the-glorious-dotfiles/wiki/Dependencies):

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
- Terminal: **Alacritty** / **XTerm** *(For battery saving)*
- File manager: **Nautilus**
- Web browser: **Brave**
- Text editor: **NeoVim / Vim**
- Screenshot tool: **Flameshot**
- Music: **Spotify**

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
- The base Awesome config is all all Gerome Matilla's as referenced in the credits.  Hence, the license is just the same as the one he used.  **Please correct me if this is not meant to be how it is!**
