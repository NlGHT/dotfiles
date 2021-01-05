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
if has("win32")
    " To all my windows friends :) (Please read the comment below if using
    " nvim)
    if empty(glob('$HOME/vimfiles/autoload/plug.vim'))
        set shell=powershell.exe
        set shellcmdflag=-Command
        set shellpipe=|
        set shellredir=>
        " This command won't work with nvim installed through Scoop (I think
        " because of permission issues)
        " To solve: Install vim and open there one time or run this command
        " below in Powershell
        silent :!Invoke-WebRequest https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -OutFile $HOME\vimfiles\autoload\plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    " Hello linux/unix fam :)
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" These are all the plugins to be installed, sorted into categories
call plug#begin('$HOME/.vim/plugged')
" Programming (Auto-Complete, Syntax, Errors, Snippets, etc.)

    " Auto-Complete
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --ts-completer --cs-completer --java-completer' } " Code completion

    " Errors/Warnings
    Plug 'w0rp/ale', { 'on': [] } " Linting and errors/warnings

    " Snippets
    Plug 'ervandew/supertab' " Supertab used so that YCM and UltiSnips co-operate
    Plug 'SirVer/ultisnips' " Track the snippet engine
    Plug 'honza/vim-snippets' " Snippets are separated from the engine

    " Additional languages
    Plug 'NlGHT/vim-eel2'
    Plug 'xolox/vim-misc' " Necessary for vim-lua-ftplugin
    Plug 'xolox/vim-lua-ftplugin' " Works with YCM
    Plug 'OmniSharp/omnisharp-vim' " Literally only here cos it has decent syntax highlighting
    Plug 'sheerun/vim-polyglot' " Bunch of language files

" Usability

    " Inline Text Usage
    Plug 'thaerkh/vim-indentguides' " Kinda like VSCode's indentation line markers
    Plug 'jmckiern/vim-venter' " Center the screen
    Plug 'unblevable/quick-scope' " Outlines unique characters after 'f'
    Plug 'junegunn/goyo.vim' " No distractions
    Plug 'preservim/nerdcommenter' " Easy comment toggling
    Plug 'godlygeek/tabular' " Alignment
    Plug 'terryma/vim-multiple-cursors'
    Plug 'liuchengxu/vim-which-key'

    " Files
    Plug 'preservim/nerdtree' " File manager
    Plug 'Xvezda/vim-nobin' " Opens the cpp if executable accidentally opened
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } " Requires yarn and node to be installed
    Plug 'ctrlpvim/ctrlp.vim' " Fuzzy finder
    Plug 'vim-scripts/a.vim' " Alternate between .c and .h with :A
    Plug 'xolox/vim-session' " Remember files opening position

    " UI
    Plug 'itchyny/lightline.vim' " Bottom bar
    Plug 'ap/vim-css-color' " Preview colours inline

" Themes

    Plug 'vim-scripts/Solarized'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'morhetz/gruvbox'
    Plug 'jacoborus/tender.vim'
    Plug 'ghifarit53/tokyonight-vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'joshdick/onedark.vim'
    Plug 'dracula/vim', { 'as': 'dracula' }
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

" Indents word-wrapped lines as much as the 'parent' line
set breakindent

function! s:setWordWrapping()
    " Ensures word-wrap does not split words
    set formatoptions=l
    set lbr
endfunction

" Only set word wrapping for pure writing filetypes
autocmd FileType markdown,text call s:setWordWrapping()

" For lightline
set laststatus=2
set noshowmode
" ================================================================= "


" ================================================================= "
"
" Theme
"
" ================================================================= "
" For making sure the colour scheme displays without transparent BG
if (has("termguicolors") && has("nvim"))
    set termguicolors
endif
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

function SetDayTheme()
    let g:lightline = {'colorscheme' : 'dracula'}

    colorscheme dracula
endfunction

function SetNightTheme()
    " Tokyo Night theme settings
    let g:tokyonight_style = 'storm' " available: night, storm
    let g:tokyonight_enable_italic = 1
    let g:lightline = {'colorscheme' : 'tokyonight'}

    colorscheme tokyonight
endfunction

" Use a lighter theme (colorscheme) during the day and darker one at night
if strftime("%H") < 19 && strftime("%H") > 10
    call SetDayTheme()
else
    call SetNightTheme()
endif

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

" Remap S to replace all
nnoremap S :%s/<C-r><C-w>//gc<Left><Left><Left>
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

" Keep the cursor position when doing page-up/down
nmap <C-b> <C-u><C-u>
nmap <C-f> <C-d><C-d>

" Vim file operations
nmap <M-q> :q!<CR>
nmap <M-x> :x<CR>

" Reload file (Like VimRC)
nnoremap <Leader>rr :source %<CR>
nnoremap <Leader>rv :source ~/.vimrc<CR>

" Diff'ing files
nmap <Leader>dp :diffput<CR>
nmap <Leader>dg :diffget<CR>

" Strip the trailing white space on write
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Abbreviations
" Alias :W to :w for saving and more (from Vim Bootstrap template)
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Derived from StackOverflow here: https://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim/741819#741819
" [TODO] Finish this to follow indentation and keep cursor position in word
function! s:swap_lines(n1, n2)
    let columnPos = col('.')
    normal! ^
    let relColumnPos = columnPos - col('.')
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
    " normal ==
    " call setpos(line1, 0)
    " normal ==
    " call setpos(line2, 0)
    " exec 'normal ^'.relColumnPos.'l'
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    " exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    " exec n + 1
endfunction

noremap <silent> <C-k> :call <SID>swap_up()<CR>
noremap <silent> <C-j> :call <SID>swap_down()<CR>

if !has('nvim')
    set ttymouse=xterm2
endif

" Multi cursor
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Session manageent
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
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
function! RefactorRenameInput()
    let wordUnderCursor = expand("<cword>")
    call inputsave()
    let name = input('RefactorRename "' . wordUnderCursor . '" to: ')
    call inputrestore()
    execute "YcmCompleter RefactorRename " . name
endfunction
nnoremap <leader>rn :call RefactorRenameInput()<CR>

" All YouCompleteMe and syntax stuff variables and options
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>'] " Add enter to accept code completion
let g:ycm_warning_symbol = '~~'
let g:ycm_goto_buffer_command = 'new-or-existing-tab' " Open GoTo in new tab or existing

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType    = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ALE (Linting)
" Don't load ALE for CS files (Doesn't seem to work with Unity)
autocmd BufRead * if &ft!="cs"|call plug#load('ale')|endif

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
autocmd VimEnter     * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Auto startup NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter     * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Auto close NERDTree if it is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" All NERDTree keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

let g:NERDTreeIgnore = [
      \ '^node_modules$',
      \ '^vendor$',
      \ '^\.git$',
      \ '^\.idea$',
      \ ]

" Fuzzy finder
nmap <leader>ff :CtrlP<CR>

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn|vendor|node_modules)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ }

" Alternate between .c and .h files (or any other head/impl)
nmap <leader>j :A<CR>
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
autocmd FileType python imap <F5> <Esc>:w<CR>:!clear && python %<CR>
autocmd FileType python map  <F5> <Esc>:w<CR>:!clear && python %<CR>

" For basic C++ compiling
autocmd FileType cpp imap <F5> <Esc>:w<CR>:!clear && g++ % -o %:t:r<CR>
autocmd FileType cpp map  <F5> <Esc>:w<CR>:!clear && g++ % -o %:t:r<CR>

" For basic C++ compiling and running
autocmd FileType cpp imap <F6> <Esc>:w<CR>:!clear && g++ % -o %:t:r && ./%:t:r<CR>
autocmd FileType cpp map  <F6> <Esc>:w<CR>:!clear && g++ % -o %:t:r && ./%:t:r<CR>

" For C++17 experimental filesystem compiling
autocmd FileType cpp imap <F7> <Esc>:w<CR>:!clear && g++ -std=c++17 % -o %:t:r -lstdc++fs<CR>
autocmd FileType cpp map  <F7> <Esc>:w<CR>:!clear && g++ -std=c++17 % -o %:t:r -lstdc++fs<CR>

" For C++17 experimental filesystem compiling (DEBUGGING)
autocmd FileType cpp imap <F8> <Esc>:w<CR>:!clear && g++ -g -std=c++17 % -o %:t:r -lstdc++fs<CR>
autocmd FileType cpp map  <F8> <Esc>:w<CR>:!clear && g++ -g -std=c++17 % -o %:t:r -lstdc++fs<CR>

" For OpenGL/GLEW/GLUT C++ compiling and running
autocmd FileType c imap <F5> <Esc>:w<CR>:!clear && g++ % -o %:t:r -lGL -lGLU -lglut -lGLEW && ./%:t:r<CR>
autocmd FileType c map  <F5> <Esc>:w<CR>:!clear && g++ % -o %:t:r -lGL -lGLU -lglut -lGLEW && ./%:t:r<CR>
"
" For basic Bash running
autocmd FileType sh imap <F5> <Esc>:w<CR>:!clear;./%<CR>
autocmd FileType sh map  <F5> <Esc>:w<CR>:!clear;./%<CR>

" For basic Bash running
autocmd FileType sh imap <F5> <Esc>:w<CR>:!clear;./%<CR>
autocmd FileType sh map  <F5> <Esc>:w<CR>:!clear;./%<CR>
" ================================================================= "


" ================================================================= "
"
" Usability
"
" ================================================================= "
" Toggle Venter (Centers screen)
nnoremap <Leader>vc :VenterToggle<CR>

" Toggle 'goyo' (Zen mode with no distractions)
map <leader>gy :Goyo<CR>
" map <leader>gyl :Goyo \| set bg=light \| set linebreak<CR>

" If executable opened instead of cpp, open it no confirmation
let g:nobin_always_yes = 1

" Colour the quick-scope plugin as the same colours everywhere
" (I don't do this anymore)
function! SetQuickScopeColours()
    highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
endfunction
" call SetQuickScopeColours()
" augroup qs_colors
    " autocmd!
    " autocmd ColorScheme * :call SetQuickScopeColours()
" augroup END

" Tim Pope Tabular Insert Mode Align Tables
inoremap <silent><Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column   = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" Keybinds for aligning text
" (credit: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)
" Align to equals
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>

" Align to after ':'
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" Align to after ':'
nmap <Leader>at :call <SID>align()<CR>
vmap <Leader>at :call <SID>align()<CR>

" Align comma separated stuff
nmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>
" ================================================================= "
