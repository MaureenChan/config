filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

"写HTML用的
Bundle 'mattn/emmet-vim'
"括号删除
Bundle 'tpope/vim-unimpaired'
"括号补全
Bundle 'Raimondi/delimitMate'
"注释
Bundle 'scrooloose/nerdcommenter'
"js
Bundle 'pangloss/vim-javascript'
"HTML5
Bundle 'othree/html5.vim'
"pythoncompletion
Bundle 'davidhalter/jedi-vim'

set softtabstop=4
set shiftwidth=4
set autoindent
set ts=4
set expandtab
set foldmethod=indent
set cindent
set wrap
filetype plugin indent on
if has("autocmd")
    autocmd FileType javascript setlocal ts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sw=2 expandtab
    autocmd FileType ruby setlocal ts=2 sw=2 expandtab
    autocmd FileType r setlocal ts=2 sw=2 expandtab
end
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2000 Jan 06
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"		for VMS:  sys$login:.vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set fileencodings=utf8,gbk
set encoding=utf8
set backspace=2
set bs=2		" allow backspacing over everything in insert mode
set sw=4
set ai			" always set autoindenting on
set incsearch
set backup		" keep a backup file
set backupdir=~/.vimbackup		" set the vi file backup dir
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
set sts=4
set ts=4
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre	*.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost	*.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost	*.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost	*.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost	*.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre			*.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre			*.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost		*.gz call GZIP_write("gzip")
  autocmd FileAppendPost		*.bz2 call GZIP_write("bzip2")

  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! GZIP_read(cmd)
    " set 'cmdheight' to two, to avoid the hit-return prompt
    let ch_save = &ch
    set ch=3
    " when filtering the whole buffer, it will become empty
    let empty = line("'[") == 1 && line("']") == line("$")
    let tmp = tempname()
    let tmpe = tmp . "." . expand("<afile>:e")
    " write the just read lines to a temp file "'[,']w tmp.gz"
    execute "'[,']w " . tmpe
    " uncompress the temp file "!gunzip tmp.gz"
    execute "!" . a:cmd . " " . tmpe
    " delete the compressed lines
    '[,']d
    " read in the uncompressed lines "'[-1r tmp"
    set nobin
    execute "'[-1r " . tmp
    " if buffer became empty, delete trailing blank line
    if empty
      normal Gdd''
    endif
    " delete the temp file
    call delete(tmp)
    let &ch = ch_save
    " When uncompressed the whole buffer, do autocommands
    if empty
      execute ":doautocmd BufReadPost " . expand("%:r")
    endif
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 1
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")

set rnu

"set tags=./tags,./../tags,./*/tags,~/work/clib/include/tags,../*/*/tags
set tags=tags,../tags,../../tags,../../../tags
"set autochdir

hi Visual ctermfg=brown ctermbg=gray gui=bold guifg=gray guibg=brown



filetype plugin on
autocmd FileType python compiler pylint

"taglist"
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=15
let Tlist_Max_Tag_length=30
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=30
let Tlist_Use_Horiz_Window=0
map <F4> :Tlist<CR>

"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . <CR>  
"map <C-F12> :!ctags * --c-types=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>      
noremap <F2> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>      
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr> 


set nocp  
let g:pylint_onwrite = 0

"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 


"按照语法高亮元素折叠代码
set foldmethod=syntax
""python按照缩进折叠代码
autocmd FileType python setlocal foldmethod=indent
"默认展开所有代码
set foldlevel=99
""随后即可使用z系列命令管理代码折叠。如za会翻转当前位置的折叠状态，
"zA会递归翻转当前层所有代码的折叠状态等。当然也可以把功能键映射到za:
map <F3> za

highlight SpellBad term=reverse ctermbg=1

" python
map <F5> :w<cr>:!python %<cr>
let mapleader=","
