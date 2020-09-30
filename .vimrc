""""" Usability
"" Turn on mouse support
set mouse=a

""""""" vim-plug
call plug#begin('~/.vim/plugged')
"""" Sensible Defaults
Plug 'tpope/vim-sensible'

"""" Filebrowsing drawer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

"""" Command line stuff:
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'ctrlpvim/ctrlp.vim'

"""" Some recommended plugins that I havent looked at yet
" Plug 'liuchengxu/vista.vim' " LSB tag browser, add later if needed

"""" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' 

"""" Syntax/lint/lsbs
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kien/rainbow_parentheses.vim'


"""""" Lanugage specific
" jsonc
Plug 'kevinoid/vim-jsonc'
" rst
Plug 'Rykka/riv.vim' 
Plug 'Rykka/InstantRst'
" csv
Plug 'chrisbra/csv.vim'

"""" Themes
Plug 'sickill/vim-monokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'

call plug#end()

"""" COC
"
" some python server stuff
command! PythonEnv CocCommand python.setInterpreter
command! Isort CocCommand python.sortImports

"
"
" from their demo config:
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" goto code nav
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


"""" Misc theme settings
syntax enable
let g:Powerline_symbols = 'fancy'
let g:airline_theme = 'understated'
let g:airline_powerline_fonts = 1

"""" Clap commands


"""" FZF settings
" create LS/FIND command
"command! LS call fzf#run(fzf#wrap({'source': 'ls -a'}))
"command! FIND call fzf#run(fzf#wrap({'source': 'find .'}))

" start nerdtree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if the last buffer is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""" TMUX line
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'x'    : '#(_get_cpu_mem)',
      \'y'    : ['%R', '%a', '%Y'],
      \'z'    : '#H'}
