"=====================================================================
"          File: .vimrc
"   Description: a personal configuration file ~/.vimrc
"        Author: sylar.liu
"       Created: 2018.6.3
"=====================================================================

"-------------------------------------------------------------------------
" Use Vim settings, rather than Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------
set nocompatible

"-------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"--------------------------------------------------------------------------
filetype plugin on
filetype indent on

"--------------------------------------------------------------------------
" Switch syntax highlighting on.
"--------------------------------------------------------------------------
syntax on

"--------------------------------------------------------------------------
" Various settings
"--------------------------------------------------------------------------
set autoindent                  " copy indent from current line 
set autoread                    " read open files again when changed outside Vim 
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode 
set browsedir=current           " which directory to use for the file browser 
set complete+=k                 " scan the files given with the 'directory' option 
set history=50                  " keep 50 lines of command line history 
set hlsearch                    " hightlight the last used search pattern 
set incsearch                   " do incremental searching 
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set mouse=a                     " enable the use of the mouse 
set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time 
set shiftwidth=2                " number of spaces to use for eanch step of indent
set showcmd                     " display incomplete commands 
set smartindent                 " smart autoindenting when starting a new line
set tabstop=4                   " number of spaces that a <Tab> counts for
set visualbell                  " visual bell instead of beeping 
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions 
set wildmenu                    " command-line completion in an enhanced mode
set nu                          
set encoding=utf-8


"===================================================================================
" Buffers, Windows
"===================================================================================
"
"-----------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-----------------------------------------------------------------------------------
if has("autocmd")
	autocmd BufEnter * :lchdir %:p:h
endif
"
"------------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when drop a file on gvim).
"------------------------------------------------------------------------------------
if has("autocmd")
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") | 
	      \ exe "normal! g'\"" | 
				\ endif
endif " has("autocmd")
"
"------------------------------------------------------------------------------------
" Change the working directory to the directory containing the current file 
"------------------------------------------------------------------------------------
if has("autocmd")
	autocmd BufEnter * :lchdir %:p:h
endif 	" has ("autocmd")
"
"------------------------------------------------------------------------------------
" comma always followed by a space
"------------------------------------------------------------------------------------
inoremap 	,	,<Space>
"
"------------------------------------------------------------------------------------
" Push quickfix window always to the bottom
"------------------------------------------------------------------------------------
if has("autocmd") 
	autocmd FileType qf wincmd J
endif

" 默认是8色的，以开启256色支持,t_Co即terminal Color之意
set t_Co=256 

" 设置vim的背景色
set background=dark

"colorscheme solarized
let g:solarized_termcolors=256
colorschem solarized
"colorschem molokai
"colorschem dracula


"=====================================================================================
" Various Plugin Configurations
"=====================================================================================
"
"-------------------------------------------------------------------------------------
" Use vundle to manage plugins
"-------------------------------------------------------------------------------------
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"
" all of your Plugins must be added before the following line 
call vundle#begin() 
Plugin 'gmarik/Vundle.vim' 					 " let Vundle manage Vundle,  required		
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'majutsushi/tagbar'
Plugin 'Lokaltog/vim-powerline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'
Plugin 'Rykka/rhythm.css'
call vundle#end()
"
"-------------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------------
"
let g:NERDTreeWinSize = 20		" set width of NERDTree
map <F2> :NERDTreeToggle<CR>		" set a shortcut key for open/close Nerd Tree
"
"*******************************************************
" 关闭vim的时候如果只剩下NERDTree，那么自动关闭NERDTree*
"*******************************************************
if has("autocmd")
	autocmd bufenter *
			\ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | 
			\ q |
			\ endif
endif
"
"*****************************************
" 当没有指定文件打开时，自动打开Nerd Tree*
"*****************************************
if has("autocmd")
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter *
		\ if argc() == 0 && !exists("s:std_in") | 
		\ NERDTree | 
		\ endif
endif
"
"*********************************************************************************
" NERDTress File highlighting(根据文件的后缀名分类，不同类的文件以不同的颜色显示)*
"*********************************************************************************
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .
		\	 ' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('xml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('h', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('cpp', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('cxx', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('cc', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('go', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('sh', 'Magenta', 'none', '#ff00ff', '#151515')
"
"-------------------------------------------------------------------------------------
" NERDTree-git-plugin
"-------------------------------------------------------------------------------------
"
"**************************************
" icons for different git status files*
"**************************************
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
"
"-------------------------------------------------------------------------------------
" Tagbar
"-------------------------------------------------------------------------------------
"
nmap <F12> :TagbarToggle<CR>    " set a shortcut key for open/close
let g:tagbar_width = 40 	      " set width of Tagbar, default is 40,:x以字符为单位 
let g:tagbar_left=0             " 设置tagbar在左还是右，默认为0(0 - left, 1 - right)

set laststatus=2			" Always show the statusline
let g:Powerline_colorscheme='solarized256'		" set colorscheme
let g:Powerline_symbols = 'fancy'
"
"========================
"setting of nredcommenter
"========================

"默认在注释符号之后添加一个空格
let g:NERDSpaceDelims = 1

"
"set 打开vim后，焦点默认在中间的窗口
" Always put this setting at the end of the filereadcmd
autocmd VimEnter * wincmd l

"**************************************
"******在头文件中自动添加头部注释******
"**************************************

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数  
autocmd BufNewFile Makefile,makefile,*.mk,*.sh exec ":call SetTitle()"   

" 对于非空的文件，按下<F4>添加头部注释
au FileType * map <F4> :call SetTitle()<cr>

" 设置作者姓名和电子邮箱
let g:Author = "sylar.liu"
let g:Email = "sylar_liu65@163.com"
  
" 加入shell的注释  
func SetComment_sh()  
    call setline(1,  "#! /usr/bin/env bash")   
    call setline(2,  "")  
    call setline(3,  "#================================================================")   
    call setline(4,  "#   Copyright (C) ".strftime("%Y")." . All rights reserved.")  
    call setline(5,  "#   ")   
    call setline(6,  "#   File Name    ： ".expand("%:t"))   
    call setline(7,  "#   Author       ： ".g:Author)  
    call setline(8,  "#   E-mail       ： ".g:Email)  
    call setline(9,  "#   Created Time ： ".strftime("%Y/%m/%d %H:%M:%S"))   
    call setline(10, "#   Description  ： ")   
    call setline(11, "#")  
    call setline(12, "#================================================================")  
    call setline(13, "")  
    call setline(14, "")  
    
    " 设置光标的位置
    call cursor(14, 1)
endfunc 

"****************************************
"******自动为脚本文件添加可执行权限******
"****************************************
"
" 自动为以 #! /usr/bin/env 开头的脚本文件添加可执行权限
au BufWritePost * call ModeChange()

function ModeChange() 
  if getline(1) =~ "#!"
    if getline(1) =~ "/usr/bin/env"
        silent !chmod a+x <afile> 
    endif 
  endif 
endfunc

"*************************************
"***** Settings for Riv **************
"*************************************
" Set default browser for rst preview
let g:instant_rst_browser = 'google-chrome'
