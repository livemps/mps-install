


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable signals (visual and audio)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noeb vb t_vb=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some type specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on " file type based indentation
augroup filetype
  autocmd BufNewFile,BufRead *.txt set filetype=human
augroup END
autocmd FileType human set formatoptions-=t textwidth=0 
autocmd FileType html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2 
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split behaviour 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

