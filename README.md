# Night's Dotfiles!!11!
## What I got
- Bulk file editing with scripts written in C++ (Will be moving to the C++17 filesystem library (Currently doesn't work for very large datasets, but will be coming soon!))
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
- A nice .vimrc that uses YouCompleteMe (not clean yet but will be soon when I figure out how to use Unity with Vim)
    - Plugged (for plugins)
    - YouCompleteMe (for auto-complete)
    - NERDTree (for file browser)
    - NERDCommenter (for commenting with code)
    - Lightline (for nicer UI)

## Operating system
Arch Linux

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
