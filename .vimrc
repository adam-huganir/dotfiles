""""" Usability
"" Turn on mouse support
set mouse=a
"" Backspace as backspace
set backspace=indent,eol,start

""""""" vim-plug
call plug#begin('~/.vim/plugged')

"""" Filebrowsing drawer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

"""" Command line stuff:
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ctrlpvim/ctrlp.vim'

"""" Some recommended plugins that I havent looked at yet
" Plug 'liuchengxu/vista.vim' " LSB tag browser, add later if needed

"""" Git support
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' 

"""" Syntax/lint/lsbs
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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



"""" Misc theme settings
syntax enable
let g:Powerline_symbols = 'fancy'
let g:airline_theme = 'understated'
let g:airline_powerline_fonts = 1

"""" FZF settings
" create LS/FIND command
"command! LS call fzf#run(fzf#wrap({'source': 'ls -a'}))
"command! FIND call fzf#run(fzf#wrap({'source': 'find .'}))

" start nerdtree if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if the last buffer is closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

