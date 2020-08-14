" ================================================================= "

"        m    m mmmmm  m    m mmmmm    mmm
"        "m  m"   #    ##  ## #   "# m"   "
"         #  #    #    # ## # #mmmm" #
"         "mm"    #    # "" # #   "m #
"   #      ##   mm#mm  #    # #    "  "mmm"

" ================================================================= "


" ================================================================= "
"
" Plugins
"
" ================================================================= "
" First off, install Plugged if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --ts-completer --cs-completer --java-completer' } " Code completion

" Supertab used so that YCM and UltiSnips co-operate
Plug 'ervandew/supertab'
" Track the snippet engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'NlGHT/vim-eel2'
Plug 'preservim/nerdtree' " File manager
Plug 'itchyny/lightline.vim' " Bottom bar
Plug 'preservim/nerdcommenter' " Easy comment toggling
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Requires yarn and node to be installed
Plug 'vim/killersheep' " New minigame

" Themes
Plug 'vim-scripts/Solarized'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
" Plug 'arcticicestudio/nord-vim' " [TODO] Why does this have transparent background?

Plug 'w0rp/ale', { 'on': [] } " Linting
call plug#end()

" Vim-Plug commands
" PlugInstall [name ...] [#threads]	Install plugins
" PlugUpdate [name ...] [#threads]	Install or update plugins
" PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade	Upgrade vim-plug itself
" PlugStatus	Check the status of plugins
" PlugDiff	Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
" ================================================================= "


" ================================================================= "
"
" Main Vim
"
" ================================================================= "
set encoding=utf-8
set expandtab
set number
set relativenumber
set hidden
set ignorecase
set shiftwidth=4
set smartcase
set mouse=a
set tabstop=4
set clipboard=unnamedplus " Clipboard just works with everything (no register shit)
set background=dark
" set lines=50 columns=1000 " Was here for usage on GNOME, vim was too small
set backspace=indent,eol,start
syntax on

" For lightline
set laststatus=2
set noshowmode
" ================================================================= "


" ================================================================= "
"
" Theme
"
" ================================================================= "
" Use a lighter theme (colorscheme) during the day and darker one at night
if strftime("%H") < 19
    colorscheme tender
else
    colorscheme gruvbox
endif
" colorscheme dracula
" colorscheme solarized

" Set XTerm opacity to be opaque when in Vim and not when not
" autocmd VimEnter * :silent !~/.bin/SetXTermsOpacityAWM 100
" autocmd WinEnter * :silent !~/.bin/SetXTermsOpacityAWM 100
" autocmd VimLeave * :silent !~/.bin/SetXTermsOpacityAWM 80
" autocmd WinLeave * :silent !~/.bin/SetXTermsOpacityAWM 80

" Change cursor in insert mode
let &t_SI = "\033[5 q"
let &t_SR = "\033[1 q"
let &t_EI = "\033[1 q"

" Highlight current working line in insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
" ================================================================= "


" ================================================================= "
"
" UTILITY & Misc Keybinds
"
" ================================================================= "
" Switching between panes
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

" Ctrl+Backspace to delete word
inoremap <C-H> <C-W>

" User-defined keyboard shortcuts
map <Space> <Leader>

" Get the wordcount of selection
map <leader>wc g<C-g>

" Put the cursor in the middle when moving views
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M

" Strip the trailing white space on write
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Alias :W to :w for saving (from https://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim)
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

if !has('nvim')
  set ttymouse=xterm2
endif
" ================================================================= "


" ================================================================= "
"
" AUTO-COMPLETE & ERRORS (YouCompleteMe, UltiSnips, ALE)
"
" ================================================================= "
" Hide completion details window (I do this on android because of lag)
set completeopt-=preview
" let g:ycm_autocose_preview_window_after_insertion = 1 " This don't work

" Stop hover details
let g:ycm_auto_hover=''

" All YouCompleteMe keybinds
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GoToType<CR>
nnoremap <leader>gi :YcmCompleter GetDoc<CR>
nnoremap <leader>gf :YcmCompleter GoToImplementation<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
nnoremap <leader>rn :YcmCompleter RefactorRename<CR>
" [TODO] Need to have some way of entering the name after RefactorRename
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>'] " Add enter to accept code completion
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ALE (Linting)
" Don't load ALE for CS files (Doesn't seem to work with Unity)
autocmd FileType * if &ft!="cs"|call plug#load('ale')|endif

" ALE jump to errors/warnings
nnoremap <leader>en :ALENextWrap<CR>
nnoremap <leader>ep :ALEPreviousWrap<CR>
" ================================================================= "


" ================================================================= "
"
" NERDTree (File Manager)
"
" ================================================================= "
" Open NERDTree when Vim starts with a directory as argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Auto startup NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Auto close NERDTree if it is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" All NERDTree keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>
" ================================================================= "


" ================================================================= "
"
" NERDCommenter (Toggle line comment tool)
"
" ================================================================= "
" Create none of the default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Toggle comments remap to cc
map <leader>cc <plug>NERDCommenterToggle
" ================================================================= "


" ================================================================= "
"
" Building and Running
"
" ================================================================= "
" For python running
autocmd FileType python imap <F5> <Esc>:w<CR>:!clear;python %<CR>
autocmd FileType python map <F5> <Esc>:w<CR>:!clear;python %<CR>

" For basic C++ compiling
autocmd FileType cpp imap <F5> <Esc>:w<CR>:!clear;g++ % -o %:t:r<CR>
autocmd FileType cpp map <F5> <Esc>:w<CR>:!clear;g++ % -o %:t:r<CR>

" For basic C++ compiling and running
autocmd FileType cpp imap <F6> <Esc>:w<CR>:!clear;g++ % -o %:t:r;./%:t:r<CR>
autocmd FileType cpp map <F6> <Esc>:w<CR>:!clear;g++ % -o %:t:r;./%:t:r<CR>

" For C++17 experimental filesystem compiling
autocmd FileType cpp imap <F7> <Esc>:w<CR>:!clear;g++ -std=c++17 % -o %:t:r -lstdc++fs<CR>
autocmd FileType cpp map <F7> <Esc>:w<CR>:!clear;g++ -std=c++17 % -o %:t:r -lstdc++fs<CR>

" For C++17 experimental filesystem compiling (DEBUGGING)
autocmd FileType cpp imap <F8> <Esc>:w<CR>:!clear;g++ -g -std=c++17 % -o %:t:r -lstdc++fs<CR>
autocmd FileType cpp map <F8> <Esc>:w<CR>:!clear;g++ -g -std=c++17 % -o %:t:r -lstdc++fs<CR>

" For basic Bash running
autocmd FileType sh imap <F5> <Esc>:w<CR>:!clear;./%<CR>
autocmd FileType sh map <F5> <Esc>:w<CR>:!clear;./%<CR>
" ================================================================= "
