" 设置背景颜色
set background=dark

if has("gui_running")
    " 设置打开位置0 0
    winpos 0 0
    " 设置行列0 0
    set lines=0 columns=0
    " 打开后默认全屏
    au GUIEnter * simalt ~x
    set guioptions -=T  "隐藏工具栏
    set guioptions -=m  "隐藏菜单栏
    set guioptions-=L  "隐藏左侧滚动条
    set guioptions-=r  "隐藏右侧滚动条
    " 字体设置
    set guifont=Consolas:h10
endif


if(has("win32") || has("win95") || has("win64") || has("win16"))
    set shell=C:\windows\system32\cmd.exe
    let g:iswindows=1
else
	let g:iswindows=0
endif

if(g:iswindows)
	let $HOMEPATH = expand("~/")
	let $PATH = $PATH.";".$HOMEPATH.".vim/exec/"
	let $PATH = $PATH.";".$HOMEPATH.".vim/gtags/"
endif

scriptencoding utf-8

" ============================================================================
" 基础配置
set nocompatible
set helplang=cn
let g:HOME=$HOME
set encoding=utf-8
let $HOME=g:HOME
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,chinese,cp936
set fileformats=unix,dos        "文件格式问题
source $VIMRUNTIME/delmenu.vim  "vim的菜单乱码解决
source $VIMRUNTIME/menu.vim     "vim的菜单乱码解决
language messages zh_CN.utf-8   "vim提示信息乱码的解决
"设置为双字宽显示，否则无法完整显示如:☆
set ambiwidth=double
" 侦测文件类型
filetype on
" 载入文件类型插件
filetype plugin on          
" 为特定文件类型载入相关缩进文件
filetype indent on

set expandtab
" 设置制表符(tab键)的宽度
set tabstop=4
" 设置软制表符的宽度
set softtabstop=4
" (自动) 缩进使用的4个空格
set shiftwidth=4            

" 开启光亮光标行 开启高亮光标列
set cursorline
set cursorcolumn

" 启动的时候不显示那个援助乌干达儿童的提示
set shortmess=atI
" 自动把内容写回文件
set autowrite
" 设置当文件被改动时自动载入
set autoread
" 在处理未保存或只读文件的时候，弹出确认 
set confirm                 " 
" 从不备份
set nobackup
set langmenu=zh_CN.UTF-8
if g:iswindows == 1
    set mouse=a
else
    set mouse=v
end
set selection=exclusive
set selectmode=mouse,key
" 去掉输入错误的提示声音
set noeb
" 一行显示不下换行显示，但不插入换行
set wrap
"set nowrap
" 禁止生成交换文件
set noswapfile
" 共享剪贴板
set clipboard+=unnamed
" 快捷终端连接
set ttyfast
" 历史记录条数
set history=100
" 标尺，用于显示光标位置的行号和列号，逗号分隔。
set ruler
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距
set scrolloff=2
" 设置退格键可用
set backspace=2
set backspace=indent,eol,start
" 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候 显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set laststatus=2            
" 输入字符串就显示匹配点
set incsearch
" highlighted search results
set hlsearch
" 搜索模式里忽略大小写
"set ignorecase

if version > 580  
    hi clear  
    if exists("syntax_on")  
        syntax reset  
    endif  
endif 

" show line numbers
set nu                      " 显示行号
set rnu                     " 显示别的行距当前行的行数

" 运行宏时不重画窗口
set lazyredraw

" 设置匹配模式，显示匹配的括号
set showmatch
" 允许折叠  
set foldenable
"折叠方式
set foldmethod=indent
"设置折叠级别 0是最高级 数值越大折叠级别越低 这样不会每次打开都折叠了
set foldlevel=9999

" 命令行设置
" 命令行显示输入的命令
set showcmd
" 命令行显示vim当前模式
set showmode

set directory=~/.vim/dirs/tmp
set backup
set backupdir=~/.vim/dirs/backups
set undofile
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo
" 将~/.vim加入到runtimepath中，使用set rtp可查看runtimepath的值
if(g:iswindows)
    set rtp+=~/.vim/
endif

if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

set t_Co=256  

source ~/.vim/plug.vim
source ~/.vim/other.vim
source ~/.vim/tags.vim
source ~/.vim/project.vim
source ~/.vim/vundle_conf.vim

syntax enable

"让vim换行后不自动添加新的注释行
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
