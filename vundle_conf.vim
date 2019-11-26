" 修改Lender为','默认为'\'
let g:mapleader = ","

call plug#begin('~/.vim/plugged')

let nerdtree_cmds = ['NERDTreeFind', 'NERDTree', 'NERDTreeToggle']
" vim 树形目录插件
Plug 'scrooloose/nerdtree', { 'on': nerdtree_cmds }
" nerdtree目录git支持
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': nerdtree_cmds }
" c++高亮增强 C++11/14 STL
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'h', 'c', 'hpp', 'cc'] }
" Airline 状态栏
Plug 'vim-airline/vim-airline'
" Airline主题
Plug 'vim-airline/vim-airline-themes'
if(g:iswindows)
    " 字体
    Plug 'eugeii/consolas-powerline-vim'
endif
" 缩进标线
Plug 'Yggdroot/indentLine'
" Vim 标签侧边栏插件
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
" markdown语法高亮
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" 代码搜索
Plug 'dyng/ctrlsf.vim', { 'on': ['<Plug>CtrlSF', 'CtrlSFToggle'] }
" 多重光标选取功能
Plug 'terryma/vim-multiple-cursors'
" 窗口管理器
Plug 't9md/vim-choosewin'
" 快速注释/解开注释
Plug 'scrooloose/nerdcommenter'
" 注释快速生成
Plug 'vim-scripts/DoxygenToolkit.vim'
" tab管理工具
Plug 'kien/tabman.vim'
"让cpp文件在.h和.cpp文件中切换
Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'h', 'c', 'hpp', 'cc'] }
" python插件
Plug 'python-mode/python-mode', { 'for': 'python'}
" 代码块补全
Plug 'SirVer/ultisnips'
" 代码块集合
Plug 'honza/vim-snippets'
" 自动补全插件
if(g:iswindows)
    Plug 'CaseZheng/YouCompleteMe'
else
    Plug 'ycm-core/YouCompleteMe'
endif
" 同时支持Git 和 Svn ，速度也是相当不错的，高亮当前修改.　比较全面的一个插件
Plug 'mhinz/vim-signify'
" git支持
Plug 'tpope/vim-fugitive'
" 查看Git详细提交日志
Plug 'gregsexton/gitv'
"撤销重做功能
Plug 'sjl/gundo.vim'
" 代码对齐插件
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
" 配色方案
Plug 'morhetz/gruvbox'
" 搜索 incsearch 增强vim中自带的 ? 和 ／ 搜索功能， 并且支持更加高级的正则表达式匹配, vim默认搜索是只能高亮一个当前匹配的字符，但是 incsearch 却可以同时高亮所有匹配的字符
Plug 'haya14busa/incsearch.vim', { 'on': ['<Plug>(incsearch-forward)', '<Plug>(incsearch-backward)', '<Plug>(incsearch-nohl-n)', '<Plug>(incsearch-nohl-N)']}
" 快速跳转
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-linebackward)', '<Plug>(easymotion-j)', '<Plug>(easymotion-k)', '<Plug>(easymotion-lineforward)', '<Plug>(easymotion-w)', '<Plug>(easymotion-b)'] }

" 查找文件插件 
let leaderf_cmds = ['LeaderfFile', 'LeaderfBuffer', 'LeaderfHistoryCmd', 'LeaderfHistorySearch']
if(g:iswindows)
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat', 'on': leaderf_cmds }
else
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh', 'on': leaderf_cmds }
endif

call plug#end()

"----------------------------------------gruvbox--------------------------------
"使用粗字体 1开启 0关闭 Enables bold text.  default: 1
let g:gruvbox_bold=0
"启用斜体注释 Enables italic for comments.  default: 1
let g:gruvbox_italicize_comments=0
let g:gruvbox_contrast_dark="hard"
if(isdirectory(expand("~/.vim/plugged/gruvbox")))
    colorscheme gruvbox
endif
"---------------------------------------------------------------------------------

"----------------------------------- nerdtree ------------------------------------
"去除第一行的帮助提示
let NERDTreeMinimalUI=1
" 打开/关闭 NERDTree
nmap <silent> <F2> :NERDTree<CR>
" 打开 NERDTree 并选中当前文件
nmap <Leader>t :NERDTreeFind<CR>
" 过滤文件和文件夹的显示
let NERDTreeIgnore = [
    \ '\.pyc$', 
    \ '\.pyo$',
    \ '\.git$',
    \ '\.svn$',
    \ '^cscope.*$',
    \ '\.sln$',
    \ '\.vcxproj$',
    \ '\.filters$',
    \ '\.vcxproj\.user$',
    \ '^.exe$',
    \ '\.docx$',
    \ '\.doc$',
    \ '\.xlsx$',
    \ '\.xls$',
    \ '\.pptx$',
    \ '\.ppt$',
    "\ '^.gitignore$',
    "\ '^.gitmodules$',
    \ ]

let NERDTreeDirArrowExpandable="-"
let NERDTreeDirArrowCollapsible="+"


" 设置宽度
let NERDTreeWinSize=40
" 排序
let NERDTreeCaseSensitiveSort=1
"let NERDTreeBookmarksFile=       "指定书签文件
let NERDTreeHighlightCursorline=1       "高亮显示光标所在行
let NERDTreeShowBookmarks=0             "当打开 NERDTree 窗口时，自动显示 Bookmarks
" 默认显示文件
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1                "默认显示隐藏文件
"let NERDTreeShowLineNumbers=1           "默认显示行号
"let NERDTreeWinPos='right'              "将 NERDTree 的窗口设置在 vim 窗口的右侧，默认在左
let NERDChristmasTree=1                 "让树更好看
"--------------------------------------------------------------------------------

"---------------------------- nerdtree-git-plugin -------------------------------
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "修",
    \ "Staged"    : "暂",
    \ "Untracked" : "跟",
    \ "Renamed"   : "重",
    \ "Unmerged"  : "合",
    \ "Deleted"   : "删",
    \ "Dirty"     : "脏",
    \ "Clean"     : "清",
    \ "Ignored"   : "忽",
    \ "Unknown"   : "未"
    \ }
"--------------------------------------------------------------------------------

"-------------------------vim-cpp-enhanced-highlight-----------------------------
"cpp-enhanced-highlight
"高亮类，成员函数，标准库和模板
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_concepts_highlight = 1
"let g:cpp_experimental_simple_template_highlight = 1
"开启声明中类名的高亮显示
"let g:cpp_class_decl_highlight = 1
"成员变量的突出显示
"let g:cpp_member_variable_highlight = 1
"类代码高亮
"let g:cpp_class_scope_highlight = 1
"文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
"let g:cpp_experimental_template_highlight = 1
"--------------------------------------------------------------------------------

"------------------------------------------- nerdcommenter ----------------------
"1、 \cc 注释当前行和选中行  
"2、 \cn 没有发现和\cc有区别  
"3、 \c<空格> 如果被选区域有部分被注释，则对被选区域执行取消注释操作，其它情况执行反转注释操作  
"4、 \cm 对被选区域用一对注释符进行注释，前面的注释对每一行都会添加注释  
"5、 \ci 执行反转注释操作，选中区域注释部分取消注释，非注释部分添加注释  
"6、 \cs 添加性感的注释，代码开头介绍部分通常使用该注释  
"7、 \cy 添加注释，并复制被添加注释的部分  
"8、 \c$ 注释当前光标到改行结尾的内容  
"9、 \cA 跳转到该行结尾添加注释，并进入编辑模式  
"10、\ca 转换注释的方式，比如： /**/和//  
"11、\cl \cb 左对齐和左右对其，左右对其主要针对/**/  
"12、\cu 取消注释 
"命令 \cc 中的 \ 为<Leader>符，<Leader>符默认为 \ 
"--------------------------------------------------------------------------------

"-------------------------------------- tagbar --------------------------- 
" toggle tagbar display 打开 Tag 列表
map <F4> :TagbarToggle<CR>
"去除第一行的帮助信息
let g:tagbar_compact = 1
" tagbar自动打开
"let g:tagbar_autofocus = 1
let g:tagbar_width = 30
"当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_autoshowtag = 1
"在tagbar中添加Lua支持
let g:tagbar_type_lua = {
    \ 'ctagstype' : 'MYLUA',
    \ 'kinds' : [
        \ 'f:Function',
        \ 'e:Item',
        \ 'v:Table',
        \ 'm:Moudle',
    \]
\}
"在tagbar中添加markdown支持
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/exec/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }
"--------------------------------------------------------------------------

"------------------------------vim-markdown--------------------------------
"禁用markdown隐藏标记的功能
set conceallevel=0
let g:vim_markdown_conceal=1
let g:tex_conceal=""
let g:vim_markdown_math=1
let g:vim_markdown_conceal_code_blocks=0
"--------------------------------------------------------------------------

"----------------------------- vim-choosewin ------------------------------
nmap  (  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1
"Default keymapings in choosewin mode
" Key Action  Description
" 0   tab_first   Select FIRST tab
" [   tab_prev    Select PREVIOUS tab
" ]   tab_next    Select NEXT tab
" $   tab_last    Select LAST tab
" x   tab_close   Close current tab
" ;   win_land    Navigate to current window
" -   previous    Naviage to previous window
" s   swap        Swap windows #1
" S   swap_stay   Swap windows but stay #1
"     win_land    Navigate to current window
"                 Disable predefined keymaping
"--------------------------------------------------------------------------

"------------------------------------ vim-airline ------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_buffers = 1
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#tab_nr_type = 0 " # of splits (default)
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
"let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
" 这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
let airline#extensions#tabline#middle_click_preserves_windows = 1
let airline#extensions#tabline#disable_refresh = 0
if(g:iswindows)
    " 设置consolas字体
    set guifont=Consolas\ for\ Powerline\ FixedD:h9
endif
if !exists('g:airline_symbols')
   let g:airline_symbols = {}
endif
let g:airline_left_sep = '>'
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
let g:airline_symbols.branch = ' '
let g:airline_symbols.readonly = ' '
let g:airline_symbols.linenr = ' '
"--------------------------------------------------------------------------
    
"------------------------------------- pymode ------------------------------
if 1
    " Python-mode
    " Activate rope
    " Keys: 按键：
    " K             Show python docs 显示Python文档
    " <Ctrl-Space>  Rope autocomplete  使用Rope进行自动补全
    " <Ctrl-c>g     Rope goto definition  跳转到定义处
    " <Ctrl-c>d     Rope show documentation  显示文档
    " <Ctrl-c>f     Rope find occurrences  寻找该对象出现的地方
    " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled) 断点
    " [[            Jump on previous class or function (normal, visual, operator modes)
    " ]]            Jump on next class or function (normal, visual, operator modes)
    "               跳转到前一个/后一个类或函数
    " [M            Jump on previous class or method (normal, visual, operator modes)
    " ]M            Jump on next class or method (normal, visual, operator modes)
    "               跳转到前一个/后一个类或方法
    let g:pymode_rope = 0

    " Documentation 显示文档
    let g:pymode_doc = 1
    let g:pymode_doc_key = '<leader>k'

    " Linting 代码查错，=1为启用
    let g:pymode_lint = 0
    let g:pymode_lint_checker = 'pyflakes,pep8'
    " Auto check on save
    let g:pymode_lint_write = 1 " 0为关闭

    " Support virtualenv
    let g:pymode_virtualenv = 1

    " Enable breakpoints plugin
    let g:pymode_breakpoint = 0 " 0为关闭
    "let g:pymode_breakpoint_bind = '<leader>b'

    " syntax highlighting 高亮形式
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_syntax_space_errors = g:pymode_syntax_all

    " Don't autofold code 禁用自动代码折叠
    let g:pymode_folding = 0

    let g:pymode_options_max_line_length = 200
endif
"--------------------------------------------------------------------------

"-----------------------------------YouCompleteMe--------------------------
"让Vim的补全菜单行为与一般IDE一致
set completeopt=longest,menu
"离开插入模式后自动关闭预览窗口，当g:ycm_add_preview_to_completeopt设为1时或者vim的completeopt设为preview有效
let g:ycm_autoclose_preview_window_after_insertion = 0
"设置触发标识符补全的最小字符数，设置为99或更大的数字，则等效于关闭标识符补全功能，但保留语义补全功能
let g:ycm_min_num_of_chars_for_completion=1
"设置要在标示符补全列表中显示的候选项的最小字符数，0表示没有限制，对语义补全无影响
let g:ycm_min_num_identifier_candidate_chars = 0
"设置语义补全的最大候选项数量，0表示没有限制
let g:ycm_max_num_candidates = 20
"设置标识符补全的最大候选项数量，0表示没有限制
let g:ycm_max_num_identifier_candidates = 20
" 0表示关闭ycm语义补全和标识符补全触发器，但仍可以用ctrl+space 打开语义补全，1表示打开
let g:ycm_auto_trigger=1
"选中补全选项后自动关闭预览窗口，当g:ycm_add_preview_to_completeopt设为1时或者vim的completeopt设为preview有效
let g:ycm_autoclose_preview_window_after_completion=1
"补全功能在注释中同样有效，1表示打开
let g:ycm_complete_in_comments = 1
"打开字符串自动补全功能。0代表关闭。这用于c系语言中#include后列出头文件很有用，如果设置为0则关闭文件名补全功能
let g:ycm_complete_in_strings = 1
"让YCM可以收集注释中的文字来分析以用于补全，默认为0，只能收集代码中的文字来分析
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"设置.ycm_extra_conf.py的全局路径，避免每次都需要复制到当前目录.若为空则每次都需复制.ycm_extra_conf.py文件到当前目录
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
"允许自动加载.ycm_extra_conf.py，不再提示 ，设置为1，则每次都提示用于确认该文件是否安全
let g:ycm_confirm_extra_conf = 0
"将诊断错误信息写道locationlist
let g:syntastic_always_populate_loc_list = 1
"使用vim的语法标识符来建立标识符数据库
let g:ycm_seed_identifiers_with_syntax = 1 
"开启tags补全引擎 ，在vim中用:h 'tags’命令来查看相关信息，只支持ctags，切必须使用--fields=+l选项
let g:ycm_collect_identifiers_from_tags_files = 1
"为当前补全选项在vim顶部增加预览窗口，用来显示函数原型等信息，如果vim的completeopt已经设置为prieview则不会有影响，:h completeopt查看相关信息，用:set completeopt?查看当前vim的设置，默认为0
let g:ycm_add_preview_to_completeopt = 0
"启用ultisnips补全，1代表允许
let g:ycm_use_ultisnips_completer = 1
"某些omni补全引擎引起与YCM缓存不适配，可能不会为给定的前缀产生所有可能的结果，如果关闭该选项则每次都重新查询omni补全引擎生成匹配项 ，默认为1代表开启
let g:ycm_cache_omnifunc=0
"设置用于选择补全列表中的第一个选项以及进入补全列表后向下选择的快捷键，默认为tab键和方向下键
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
"设置用于向上选择补全列表中的选项的快捷键，默认为shift+tab，和方向上键
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
"设置用于关闭补全列表的快捷键，默认为ctrl+y
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
"设置强制启用语义补全的快捷键,默认是CTRL + space
let g:ycm_key_invoke_completion = "<C-x><C-h>"
"设置YCM的文件名补全时，相对路径是按照vim的当前工作目录还是活动缓冲区中的文件所在目录来解释。0是按照文件所在目录
let g:ycm_filepath_completion_use_working_dir = 0
"此选项控制使用哪种排名和过滤算法 '1'：使用ycmd的缓存和过滤逻辑。 '0'：使用clangd的缓存和过滤逻辑。
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_args = ['-log=verbose', '-pretty']
"打开/关闭编译错误列表
nnoremap <leader>eo :lopen<CR>
nnoremap <leader>ec :lclose<CR>
"跳转到申明或定义
nnoremap <leader>ee :YcmCompleter GoToDefinitionElseDeclaration<CR>
"跳转到定义
nnoremap <leader>ef :YcmCompleter GoToDefinition<CR>
"跳转到声明
nnoremap <leader>el :YcmCompleter GoToDeclaration<CR>

"文件类型黑名单，vim打开这些类型文件时会关闭YCM
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'nerdtree' : 1,
      \}
"语义补全黑名单，vim打开这些类型文件时会关闭YCM语义补全，但标识符补全仍可用
let g:ycm_filetype_specific_completion_to_disable={'gitcommit': 1}
"对特定文件类型禁用文件路径补全
let g:ycm_filepath_blacklist = {'html' : 1, 'jsx' : 1,'xml' : 1,}
"文件类型白名单，vim打开这些类型文件时会开启YCM
let g:ycm_filetype_whitelist = { 
    \ "py":1,
    \ "lua":1,
    \ "sh":1,
    \ "h":1,
    \ "hpp":1,
    \ "hxx":1,
    \ "hh":1,
    \ "inl":1,
    \ "cxx":1,
    \ "cc":1,
    \ "c":1,
    \ "cpp":1
    \ }
"设置YCM的语义触发器的关键字 代表在 C/C++ 下面写代码的时候必须输入：. 或 -> 或 :: 才能弹出语义补全, 这里追加了一个正则表达式，代表相关语言的源文件中，用户只需要输入符号的几个字母，即可自动弹出语义补全, 默认的 . / -> / :: 是不会被覆盖的
let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.', 're!\w{2}'],
  \   'cpp,cuda,objcpp': ['->', '.', '::', 're!\w{2}'],
  \   'php': ['->', '::'],
  \   'go,java,javascript,python': ['.'],
  \   'lua': ['.', ':', 're!\w{2}'],
  \ }
"设置错误标志
let g:ycm_error_symbol = 'EE'
"设置警告标志
let g:ycm_warning_symbol = 'WW'
"开启YCM的显示诊断信息的功能，0表示关闭
let g:ycm_show_diagnostics_ui = 0
"在代码中高亮显示YCM诊断对应的内容，如果关闭，则会关闭错误和警告高亮功能，0表示关闭
let g:ycm_enable_diagnostic_signs = 0
"高亮显示代码中与诊断信息有关的文本或代码，0表示关闭
let g:ycm_enable_diagnostic_highlighting = 0
"当光标移到所在行时显示诊断信息
let g:ycm_echo_current_diagnostic = 1
"此选项控制在文件中检测到错误或警告时向用户显示的最大诊断数
let g:ycm_max_diagnostics_to_display = 30
"设置YCM的日志记录级别，可以是debug，info，warning，error或critical。debug是最详细的
let g:ycm_server_log_level = 'error'
"--------------------------------------------------------------------------

"------------------------------------ vim-signify -------------------------
let g:signify_vcs_list = [ 'git', 'svn' ]
"let g:signify_difftool = 'gnudiff' "设置后windos下svn的对比不可用，屏蔽
"let g:signify_vcs_cmds = {
"    \ }
" 下一个变更
nmap <leader>gj <plug>(signify-next-hunk)   
" 上一个变更
nmap <leader>gk <plug>(signify-prev-hunk)
" 第一个变更
nmap <leader>gJ 9999<leader>gj
" 最后一个变更
nmap <leader>gK 9999<leader>gk
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227
"--------------------------------------------------------------------------


"---------------------------------- tabular -------------------------------
"代码对齐
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a/ :Tabularize /\/\/<CR>
vmap <Leader>a/ :Tabularize /\/\/<CR>
nmap <Leader>a  :Tabularize /
vmap <Leader>a  :Tabularize /
"--------------------------------------------------------------------------

"------------------------------------------indentLine----------------------
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '¦'
let g:indentLine_concealcursor = ''
"--------------------------------------------------------------------------

"-------------------------------------- ctrlsf ----------------------------
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_default_view_mode='compact'
let g:ctrlsf_default_root='cwd'     "设置在当前工作目录下搜索
let g:ctrlsf_case_sensitive='no'    "大小写不敏感
"设置自动关闭,不同模式下不同设置
let g:ctrlsf_auto_close = {
    \ "normal" : 0,
    \ "compact": 0
    \}
let g:ctrlsf_populate_qflist = 1    "结果输出到quickfix
let g:ctrlsf_ignore_dir = ['cscope.out', 'cscope.tags', 'cscope.files']
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '30%'
nmap <Leader>ft <Plug>CtrlSFPrompt
vmap <Leader>ft <Plug>CtrlSFVwordPath
nmap <leader>fw <Plug>CtrlSFCwordPath<CR>
vmap <leader>fw <Plug>CtrlSFVwordExec
nmap <leader>fl :CtrlSFToggle<CR>
"--------------------------------------------------------------------------

"-------------------------------------- tabman ----------------------------
"开启/关闭tab管理
let g:tabman_toggle = '<leader>tl'
"将光标移动到tab管理窗口
let g:tabman_focus  = '<leader>tf'
let g:tabman_width = 25
let g:tabman_side = 'left'
let g:tabman_specials = 0
let g:tabman_number = 1
"---------------------------------------------------------------------------

"-------------------------------------- gundo ------------------------------
nnoremap <Leader>u :GundoToggle<CR>
if(has('python3'))
    let g:gundo_prefer_python3 = 1
endif
"---------------------------------------------------------------------------

"----------------------------------------------- a.vim ---------------------
map <F6> :A<CR>
"---------------------------------------------------------------------------

"-------------------------------------- vim-easymotion ----------------------------
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_use_upper = 1
map <Leader><Leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><Leader>l <Plug>(easymotion-lineforward)
map <Leader><Leader>w <Plug>(easymotion-w)
map <Leader><Leader>b <Plug>(easymotion-b)
"--------------------------------------------------------------------------


"-------------------------------------- LeaderF ----------------------------
let g:Lf_UseCache=0
let g:Lf_UseMemoryCache=0
let g:Lf_ReverseOrder=1
"搜索当前文件下的文件
map <leader>lf :LeaderfFile<CR>
map <leader>lb :LeaderfBuffer<CR>
map <leader>lc :LeaderfHistoryCmd<CR>
map <leader>ls :LeaderfHistorySearch<CR>
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
        \}
"--------------------------------------------------------------------------

"-------------------------------------- ultisnips ----------------------------
"快速插入代码片段
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsEditSplit="vertical"
"--------------------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""" 注释 DoxygenToolkit""""""""""""""""
let g:DoxygenToolkit_briefTag_funcName = "yes"
"let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre = "Description: "            "描述
let g:DoxygenToolkit_templateParamTag_pre = "TTaram: "
let g:DoxygenToolkit_paramTag_pre = "Param: "                "参数
let g:DoxygenToolkit_returnTag = "Return: "                 "返回值
let g:DoxygenToolkit_throwTag_pre = "Throw " " @exception is also valid
let g:DoxygenToolkit_fileTag = "FileName: "                     "文件名
let g:DoxygenToolkit_dateTag = "Date: "                     "日期
let g:DoxygenToolkit_authorTag = "Author: "                 "作者
let g:DoxygenToolkit_versionTag = "Version: "               "版本
let g:DoxygenToolkit_blockTag = "Name: "
let g:DoxygenToolkit_classTag = "Class: "
let g:DoxygenToolkit_authorName = "CaseZheng"
let g:doxygen_enhanced_color = 1
"let g:load_doxygen_syntax = 1
"文件注释
nmap <Leader>dl :DoxAuthor<CR>
"函数/类注释
nmap <Leader>dd :Dox<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""incsearch"""""""""""""""""""""""""""""""""""
"map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""vim-fugitive""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""gitv""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags=cscope.tags
if has("cscope")
    "设定cst选项同时搜索cscope数据库和标签文件
    set cst
    "如果csto被设为0,cscope数据库先被搜索,搜索失败的情况下在搜索标签文件.如果csto被设为1,标签文件会在cscope数据库之前被搜索
    set csto=0
    set csverb
    nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>	
endif


set wildmenu
set wildmode=full

"--------------------------------------------------------------------------------------------------

autocmd BufNewFile * normal G

"更新TAG
map <F10> :call Do_CsTag()<CR><CR>
map <F11> :call ResetCscope(1, 1)<CR>
map <F3> :call CloseAllBuffer()<CR>
map <F5> :call PrintKeyMap()<CR>

iab xdatetime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab xdate <c-r>=strftime("%Y-%m-%d")<CR>

" 取消高亮
nmap <leader>nh :nohl<CR>
