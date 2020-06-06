" First off, install Plugged if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" CoC - Use release branch (Recommend)
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ycm-core/YouCompleteMe' " Code completion

Plug 'preservim/nerdtree' " File manager
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter' " Easy comment toggling
Plug 'vim/killersheep' " New minigame

" Themes
Plug 'vim-scripts/Solarized'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'dracula/vim', { 'as': 'dracula' } " Dracula also has transparent background????
" Plug 'arcticicestudio/nord-vim' " Why does this have transparent background

" Plug 'OmniSharp/omnisharp-vim'
Plug 'w0rp/ale' " Linting
call plug#end()

" Vim-Plug commands
" PlugInstall [name ...] [#threads]	Install plugins
" PlugUpdate [name ...] [#threads]	Install or update plugins
" PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade	Upgrade vim-plug itself
" PlugStatus	Check the status of plugins
" PlugDiff	Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins


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


" Themes

" Use a lighter theme during the day and darker one at night
if strftime("%H") < 19
    colorscheme tender
else
    colorscheme gruvbox
endif
" colorscheme dracula
" colorscheme solarized

" set lines=50 columns=1000 " Was here for usage on GNOME, vim was too small
set backspace=indent,eol,start
" set linespace=10
" set cursorline
syntax on

if !has('nvim')
  set ttymouse=xterm2
endif

" For lightline
set laststatus=2
set noshowmode

" For NERDTree
" Open NERDTree when Vim starts with a directory as argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Auto startup NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Auto close NERDTree if it is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" User-defined keyboard shortcuts
map <Space> <Leader>

" All YouCompleteMe keybinds
nnoremap <leader>gg :YcmCompleter GoTo<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt :YcmCompleter GoToType<CR>
nnoremap <leader>gi :YcmCompleter GetDoc<CR>
nnoremap <leader>gf :YcmCompleter GoToImplementation<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
nnoremap <leader>rn :YcmCompleter RefactorRename<CR> 
" Need to fix this ^^^^^^^^^^^, need to have some way of entering the name
" after RefactorRename
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>'] " Add enter to accept code completion

" All NERDTree keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

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

" For python running
autocmd FileType python imap <F5> <Esc>:w<CR>:!clear;python %<CR>
autocmd FileType python map <F5> <Esc>:w<CR>:!clear;python %<CR>

" For basic C++ compiling
autocmd FileType cpp imap <F5> <Esc>:w<CR>:!clear;g++ % -o %:t:r<CR>
autocmd FileType cpp map <F5> <Esc>:w<CR>:!clear;g++ % -o %:t:r<CR>

" For basic C++ compiling and running
autocmd FileType cpp imap <F6> <Esc>:w<CR>:!clear;g++ % -o %:t:r;./%:t:r<CR>
autocmd FileType cpp map <F6> <Esc>:w<CR>:!clear;g++ % -o %:t:r;./%:t:r<CR>

" For basic Bash running
autocmd FileType sh imap <F5> <Esc>:w<CR>:!clear;./%<CR>
autocmd FileType sh map <F5> <Esc>:w<CR>:!clear;./%<CR>

" For setting the background terminal colour just for vim
" let t:is_transparent = 1
" hi Normal guibg=#111111 ctermbg=black

" function! Toggle_transparent_background()
    " if t:is_transparent == 0
        " hi Normal guibg=#111111 ctermbg=black
        " let t:is_transparent = 1
    " else
        " hi Normal guibg=NONE ctermbg=NONE
        " let t:is_transparent = 0
    " endif
" endfunction

" nnoremap <C-x><C-t> :call Toggle_transparent_background()<CR>

" EEL File Type
" au BufNewFile,BufRead *.eel setfiletype eel2


" For NERDCommenter

" Create none of the default mappings
let g:NERDCreateDefaultMappings = 0

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Toggle comments remap to cc
map <leader>cc <plug>NERDCommenterToggle



" Handy remapping of normal keys
" Get the wordcount of selection
map <leader>wc g<C-g>

" Put the cursor in the middle when moving views
nnoremap <C-d> <C-d>M
nnoremap <C-u> <C-u>M
nnoremap <C-f> <C-f>M
nnoremap <C-b> <C-b>M




" CoC
" CoC Extensions
" let g:coc_global_extensions = [
"     \ 'coc-marketplace',
"     \ 'coc-pairs',
"     \ 'coc-angular',
"     \ 'coc-clangd',
"     \ 'coc-highlight',
"     \ 'coc-html',
"     \ 'coc-java',
"     \ 'coc-json',
"     \ 'coc-markdownlint',
"     \ 'coc-omnisharp',
"     \ 'coc-python',
"     \ 'coc-jedi',
"     \ 'coc-r-lsp',
"     \ 'coc-snippets',
"     \ 'coc-spell-checker',
"     \ 'coc-svg',
"     \ 'coc-tsserver',
"     \ 'coc-lua',
"     \ ]
" 
" " TextEdit might fail if hidden is not set.
" set hidden
" 
" " Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup
" 
" " Give more space for displaying messages.
" set cmdheight=2
" 
" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" " delays and poor user experience.
" set updatetime=300
" 
" " Don't pass messages to |ins-completion-menu|.
" set shortmess+=c
" 
" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" set signcolumn=yes
" 
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" 
" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" 
" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif
" 
" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 
" " GoTo code navigation.
" nmap <silent><leader>gg <Plug>(coc-definition)
" nmap <silent><leader>gi <Plug>(coc-type-definition)
" nmap <silent><leader>gf <Plug>(coc-implementation)
" nmap <silent><leader>gr <Plug>(coc-references)
" 
" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
" 
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction
" 
" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" 
" " Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
" 
" " Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" 
" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
" 
" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
" 
" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)
" 
" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
" 
" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
" 
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
" 
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" 
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 
" " Mappings using CoCList:
" " Show all diagnostics.
" nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>






"   From OmniSharp
" 
"  Note: this is required for the plugin to work
" iletype indent plugin on
" 
"  Use the stdio OmniSharp-roslyn server
" et g:OmniSharp_server_stdio = 1
" 
"  Set the type lookup function to use the preview window instead of echoing it
" let g:OmniSharp_typeLookupInPreview = 1
" 
"  Timeout in seconds to wait for a response from the server
" et g:OmniSharp_timeout = 5
" 
"  Don't autoselect first omnicomplete option, show options even if there is only
"  one (so the preview documentation is accessible). Remove 'preview', 'popup'
"  and 'popuphidden' if you don't want to see any documentation whatsoever.
"  Note that neovim does not support `popuphidden` or `popup` yet: 
"  https://github.com/neovim/neovim/issues/10996
"  set completeopt=longest,menuone,preview,popuphidden
" 
"  Highlight the completion documentation popup background/foreground the same as
"  the completion menu itself, for better readability with highlighted
"  documentation.
"  set completepopup=highlight:Pmenu,border:off
" 
"  Fetch full documentation during omnicomplete requests.
"  By default, only Type/Method signatures are fetched. Full documentation can
"  still be fetched when you need it with the :OmniSharpDocumentation command.
" et g:omnicomplete_fetch_full_documentation = 1
" 
"  Set desired preview window height for viewing documentation.
"  You might also want to look at the echodoc plugin.
" et previewheight=5
" 
"  Tell ALE to use OmniSharp for linting C# files, and no other linters.
" et g:ale_linters = { 'cs': ['OmniSharp'] }
" 
"  Update semantic highlighting on BufEnter, InsertLeave and TextChanged
" et g:OmniSharp_highlight_types = 2
" 
" ugroup omnisharp_commands
"    autocmd!
" 
"    " Show type information automatically when the cursor stops moving.
"    " Note that the type is echoed to the Vim command line, and will overwrite
"    " any other messages in this space including e.g. ALE linting messages.
"    autocmd CursorHold *.cs OmniSharpTypeLookup
" 
"    " The following commands are contextual, based on the cursor position.
"    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>
" 
"    " Finds members in the current buffer
"    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>
" 
"    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
"    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
"    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
"    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>
" 
"    " Navigate up and down by method/property/field
"    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
"    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
" 
"    " Find all code errors/warnings for the current solution and populate the quickfix window
"    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
" ugroup END
" 
"  Contextual code actions (uses fzf, CtrlP or unite.vim when available)
" noremap <Leader><Space> :OmniSharpGetCodeActions<CR>
"  Run code actions with text selected in visual mode to extract method
" noremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>
" 
"  Rename with dialog
" noremap <Leader>nm :OmniSharpRename<CR>
" noremap <F2> :OmniSharpRename<CR>
"  Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
" ommand! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
" 
" noremap <Leader>cf :OmniSharpCodeFormat<CR>
" 
"  Start the omnisharp server for the current solution
" noremap <Leader>ss :OmniSharpStartServer<CR>
" noremap <Leader>sp :OmniSharpStopServer<CR>
" 
"  Enable snippet completion
"  let g:OmniSharp_want_snippet=1
