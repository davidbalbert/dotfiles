set nocompatible                  " Must come first because it changes other options.

call pathogen#infect()

syntax enable                     " Turn on syntax highlighting.
colorscheme grb256

filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

" set title                         " Set the terminal's title
set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set mouse=a                       " mouse support

set clipboard=unnamed             " use system clipboard

" Omnicomplete
set completeopt=menu,menuone,longest

" UNCOMMENT TO USE
set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs
set smarttab

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\%{exists('fugitive#statusline')?fugitive#statusline():''}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set list listchars=tab:\ \ ,trail:·

" set up map leader
let mapleader=","

" get rid of search hilights
nnoremap <silent> <leader>/ :nohlsearch<cr>
" Use javascript plugin for json
augroup filetype_json
  autocmd!
  autocmd BufNewFile,BufRead *.json set ft=javascript
augroup END

" for ctags
nnoremap <leader>rt :!ctags --extra=+f -R *<CR><CR>
" jump to definition
nnoremap <leader>d <C-]>
" jump back from definition
nnoremap <leader>c <C-t>
" open definition in a new vertical split
nnoremap <leader>s :vsp <CR><C-w>l:exec("tag ".expand("<cword>"))<CR>


" for editing and reloading .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" VimOrganizer
augroup filetype_org
  autocmd!
  au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
  au BufEnter *.org            call org#SetOrgFileType()
augroup END
