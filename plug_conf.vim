if exists('g:loaded_self_plug_conf')
    finish
endif

let g:loaded_self_plug_conf = 1

" 修改Lender为','默认为'\'
let g:mapleader = ","

let g:plugged_path = g:vim_conf_path."/plugged"

call plug#begin(g:plugged_path)

" 配色方案
Plug 'morhetz/gruvbox'

" 高亮多个单词
Plug 'lfv89/vim-interestingwords'

" 文件管理
Plug 'Shougo/defx.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'

" c++高亮增强 C++11/14 STL
Plug 'octol/vim-cpp-enhanced-highlight'

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
Plug 'plasticboy/vim-markdown'

" 多重光标选取功能
Plug 'terryma/vim-multiple-cursors'

" 窗口管理器
Plug 't9md/vim-choosewin'

" 快速注释/解开注释
Plug 'scrooloose/nerdcommenter', { 'for': [ 'cpp', 'vim', 'sh', 'python', 'go' ] }

" 代码块补全
Plug 'SirVer/ultisnips', { 'for': [ 'cpp' ] }

" 自动补全插件
if(g:iswindows)
    Plug 'CaseZheng/YouCompleteMe', { 'for': [ 'cpp', 'python', 'go' ] }
else
    Plug 'ycm-core/YouCompleteMe', { 'for': [ 'cpp', 'python', 'go' ] }
endif

" 同时支持Git 和 Svn ，高亮当前修改
Plug 'mhinz/vim-signify', { 'for': [ 'cpp', 'vim', 'sh', 'python', 'go' ] }

" git支持
Plug 'tpope/vim-fugitive', { 'for': [ 'cpp', 'vim', 'sh', 'python', 'go' ] }

"撤销重做功能
Plug 'sjl/gundo.vim'

" 代码对齐插件
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" 快速跳转
Plug 'easymotion/vim-easymotion', { 'on': ['<Plug>(easymotion-linebackward)', '<Plug>(easymotion-j)', '<Plug>(easymotion-k)', '<Plug>(easymotion-lineforward)', '<Plug>(easymotion-w)', '<Plug>(easymotion-b)'] }

" 语法格式提示
Plug 'dense-analysis/ale'

" 查找文件插件
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension'}

" terminal封装插件
Plug 'skywind3000/vim-terminal-help'

call plug#end()

" gruvbox =================================================================== {{{
  "使用粗字体 1开启 0关闭 Enables bold text.  default: 1
  let g:gruvbox_bold=0
  "启用斜体注释 Enables italic for comments.  default: 1
  let g:gruvbox_italicize_comments=0
  let g:gruvbox_contrast_dark="hard"

  if(isdirectory(g:vim_conf_path."/plugged/gruvbox"))
      colorscheme gruvbox
  endif
" }}}

" defx =================================================================== {{{
  nmap <silent> <F2> :Defx<CR>
	autocmd FileType defx call s:defx_my_settings()

	function! s:defx_my_settings() abort
    " 不在defx栏不显示行号
    setl nonu
    " 打开目录或文档
	  nnoremap <silent><buffer><expr> <CR>
            \ defx#is_directory() ?
            \ defx#do_action('open_tree', 'toggle') :
            \ defx#do_action('open', 'choose')
   " 打开文档
	  nnoremap <silent><buffer><expr> e defx#do_action('open', 'vsplit')
    " 预览
	  nnoremap <silent><buffer><expr> P defx#do_action('preview')
    " 拷贝
	  nnoremap <silent><buffer><expr> c defx#do_action('copy')
    " 删除
	  nnoremap <silent><buffer><expr> m defx#do_action('move')
    " 粘帖
	  nnoremap <silent><buffer><expr> p defx#do_action('paste')
    " 创建新目录
	  nnoremap <silent><buffer><expr> nd defx#do_action('new_directory')
    " 创建新文件
	  nnoremap <silent><buffer><expr> nf defx#do_action('new_file')
    " 删除文件
	  nnoremap <silent><buffer><expr> rm defx#do_action('remove')
    " 文件改名
	  nnoremap <silent><buffer><expr> rn defx#do_action('rename')
    " 执行文件
	  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    " 复制文件地址
	  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    " 显示/忽略隐藏文件
	  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    " 打开上一个目录
	  nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
    " 打开家目录
	  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    " 打开当前目录并改变根目录
	  nnoremap <silent><buffer><expr> cd defx#do_action('cd', [defx#get_candidate().action__path])
    " 打开到当前根目录
	  nnoremap <silent><buffer><expr> CD defx#do_action('cd', [getcwd()])
    " 退出目录
	  nnoremap <silent><buffer><expr> q defx#do_action('quit')
    " 向下
	  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    " 向上
	  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    " 刷新Defx
	  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
    " 打印文件名
	  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
    " 扩大defx宽度
    nnoremap <silent><buffer><expr> > defx#do_action('resize', defx#get_context().winwidth + 10)
    " 缩写defx宽度
    nnoremap <silent><buffer><expr> < defx#do_action('resize', defx#get_context().winwidth - 10)
	endfunction

  call defx#custom#column('icon', {
      \ 'directory_icon': '>',
      \ 'opened_icon': '-',
      \ 'root_icon': ' ',
      \ })

  call defx#custom#option('_', {
    \ 'ignored_files': '*.pyc,*.pyo,*.sln,*.vcxproj,*.filters,*.exe,*.docx,*.doc,*.xlsx,*.xls,*.pptx,*.ppt,*.pytest_cache,*.py1.stats,GPATH,__pycache__,cscope.*,GTAGS,GRTAGS',
    \ 'ignored_recursive_files': '',
    \ 'auto_cd': 1,
    \ 'winwidth': 50,
    \ 'split': 'vertical',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'resume': 1,
    \ 'toggle': 1,
    \ 'direction': 'topleft',
    \ 'columns': 'git:indent:icon:filename',
    \ })
" }}}

" defx-git =================================================================== {{{
  call defx#custom#column('git', 'indicators', {
    \ 'Modified'  : 'M',
    \ 'Staged'    : 'S',
    \ 'Untracked' : 'U',
    \ 'Renamed'   : 'R',
    \ 'Unmerged'  : '=',
    \ 'Ignored'   : 'I',
    \ 'Deleted'   : 'D',
    \ 'Unknown'   : '?'
    \ })

  call defx#custom#column('git', 'column_length', 0)
  hi def link Defx_filename_directory NERDTreeDirSlash
  hi def link Defx_git_Modified Special
  hi def link Defx_git_Staged Function
  hi def link Defx_git_Renamed Title
  hi def link Defx_git_Unmerged Label
  hi def link Defx_git_Untracked Tag
  hi def link Defx_git_Ignored Comment
" }}}

" vim-cpp-enhanced-highlight =================================================================== {{{
  "高亮类，成员函数，标准库和模板
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_concepts_highlight = 1
  let g:cpp_experimental_simple_template_highlight = 1
  "开启声明中类名的高亮显示
  let g:cpp_class_decl_highlight = 1
  "成员变量的突出显示
  "let g:cpp_member_variable_highlight = 1
  "类代码高亮
  let g:cpp_class_scope_highlight = 1
  "文件较大时使用下面的设置高亮模板速度较快，但会有一些小错误
  let g:cpp_experimental_template_highlight = 1
" }}}

" vim-airline =================================================================== {{{
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
  let g:airline_left_sep = '>'
  let g:airline_left_alt_sep = ' '
  let g:airline_right_sep = ' '
  let g:airline_right_alt_sep = ' '
  let g:airline_symbols = {}
  let g:airline_symbols.branch = ' '
  let g:airline_symbols.readonly = ' '
  let g:airline_symbols.linenr = ' '
" }}}

" indentLine =================================================================== {{{
  let g:indentLine_noConcealCursor = 1
  let g:indentLine_color_term = 0
  let g:indentLine_char = '¦'
  let g:indentLine_concealcursor = ''
" }}}

" tagbar =================================================================== {{{
  " toggle tagbar display 打开 Tag 列表
  map <F4> :TagbarToggle<CR>
  "去除第一行的帮助信息
  let g:tagbar_compact = 1
  " tagbar自动打开
  "let g:tagbar_autofocus = 1
  let g:tagbar_width = 30
  "当编辑代码时，在Tagbar自动追踪变量
  let g:tagbar_autoshowtag = 1
" }}}

" vim-markdown =================================================================== {{{
  "禁用markdown隐藏标记的功能
  set conceallevel=0
  let g:vim_markdown_conceal=1
  let g:tex_conceal=""
  let g:vim_markdown_math=1
  let g:vim_markdown_conceal_code_blocks=0
" }}}

" vim-choosewin =================================================================== {{{
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
" }}}

" nerdcommenter =================================================================== {{{
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
" }}}

" ultisnips =================================================================== {{{
  "快速插入代码片段
  let g:UltiSnipsExpandTrigger="<C-j>"
  let g:UltiSnipsJumpForwardTrigger="<C-j>"
  let g:UltiSnipsJumpBackwardTrigger="<C-k>"
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsSnippetDirectories=[g:vim_conf_path.'/UltiSnips']
" }}}

" YouCompleteMe =================================================================== {{{
  "让Vim的补全菜单行为与一般IDE一致
  set completeopt=longest,menu
  "离开插入模式后自动关闭预览窗口，当g:ycm_add_preview_to_completeopt设为1时或者vim的completeopt设为preview有效
  let g:ycm_autoclose_preview_window_after_insertion = 0
  "设置触发标识符补全的最小字符数，设置为99或更大的数字，则等效于关闭标识符补全功能，但保留语义补全功能
  let g:ycm_min_num_of_chars_for_completion=1
  "设置要在标示符补全列表中显示的候选项的最小字符数，0表示没有限制，对语义补全无影响
  let g:ycm_min_num_identifier_candidate_chars = 0
  "设置语义补全的最大候选项数量，0表示没有限制
  let g:ycm_max_num_candidates = 30
  "设置标识符补全的最大候选项数量，0表示没有限制
  let g:ycm_max_num_identifier_candidates = 10
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
  let g:ycm_global_ycm_extra_conf = g:vim_conf_path.'/ycm_extra_conf.py'
  "允许自动加载.ycm_extra_conf.py，不再提示 ，设置为1，则每次都提示用于确认该文件是否安全
  let g:ycm_confirm_extra_conf = 0
  "设置加载 .ycm_extra_conf.py的路径，*表示匹配任何字符，?匹配任何单个字符，[seq] 匹配seq中的任何单个字符，[!seq] 匹配不在seq中的任何单个字符，路径前加！表示不加载所有改路径上匹配的文件
  let g:ycm_extra_conf_globlist = []
  "将诊断错误信息写道locationlist
  let g:syntastic_always_populate_loc_list = 1
  "使用vim的语法标识符来建立标识符数据库
  let g:ycm_seed_identifiers_with_syntax = 1
  "将数据从Vim发送到.ycm_extra_conf.py文件中的FlagsForFile函数
  let g:ycm_extra_conf_vim_data = []
  "为ycm服务器指定特定的python解释器，默认为空表示在系统上搜索适当的Python解释器
  let g:ycm_server_python_interpreter = ''
  "YCM关闭时保存日志，0表示关闭
  let g:ycm_keep_logfiles = 0
  "开启tags补全引擎 ，在vim中用:h 'tags'命令来查看相关信息，只支持ctags，切必须使用--fields=+l选项
  let g:ycm_collect_identifiers_from_tags_files = 0
  "为当前补全选项在vim顶部增加预览窗口，用来显示函数原型等信息，如果vim的completeopt已经设置为prieview则不会有影响，:h completeopt查看相关信息，用:set completeopt?查看当前vim的设置，默认为0
  let g:ycm_add_preview_to_completeopt = 0
  "启用ultisnips补全，1代表允许
  let g:ycm_use_ultisnips_completer = 1
  "设置使用goto跳转快捷键时新窗口的打开方式
  let g:ycm_goto_buffer_command = 'same-buffer'
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
  "设置查看光标停留处的错误诊断详细信息的快捷键,默认为,d
  let g:ycm_key_detailed_diagnostics = ''
  "设置YCM的作用的文件大小上限，单位为Kb，0表示无上限
  let g:ycm_disable_for_files_larger_than_kb = 0
  "启用clangd
  let g:ycm_use_clangd = 1
  "此选项控制使用哪种排名和过滤算法 '1'：使用ycmd的缓存和过滤逻辑。 '0'：使用clangd的缓存和过滤逻辑。
  let g:ycm_clangd_uses_ycmd_caching = 0
  let g:ycm_clangd_args = ['-log=verbose', '-pretty']
  let g:ycm_auto_hover = 'CursorHold'

  "跳转
  nmap <leader>et :YcmCompleter GoTo<CR>
  "符号查找
  nmap <leader>es :YcmCompleter GoToSymbol
  "跳转到引用
  nmap <leader>er :YcmCompleter GoToReferences<CR>
  "重命名标识符
  nmap <leader>en :YcmCompleter RefactorRename
  "格式化
  autocmd FileType cpp nnoremap <leader>ef  :YcmComplete Format<CR>
  autocmd FileType go nnoremap <leader>ef  :YcmComplete Format<CR>
  nmap <leader>D <plug>(YCMHover)

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
      \ "python":1,
      \ "lua":1,
      \ "c":1,
      \ "cpp":1,
      \ "go":1
      \ }
  "设置YCM的语义触发器的关键字 代表在 C/C++ 下面写代码的时候必须输入：. 或 -> 或 :: 才能弹出语义补全, 这里追加了一个正则表达式，代表相关语言的源文件中，用户只需要输入符号的几个字母，即可自动弹出语义补全, 默认的 . / -> / :: 是不会被覆盖的
  let g:ycm_semantic_triggers =  {
    \   'c': ['->', '.', 're!\w{2}'],
    \   'cpp': ['->', '.', '::', 're!\w{2}'],
    \   'go,python': ['.'],
    \   'lua': ['.', ':', 're!\w{2}'],
    \ }
  "设置错误标志
  let g:ycm_error_symbol = '_E'
  "设置警告标志
  let g:ycm_warning_symbol = '_W'
  "开启YCM的显示诊断信息的功能，0表示关闭
  let g:ycm_show_diagnostics_ui = 0
  "在代码中高亮显示YCM诊断对应的内容，如果关闭，则会关闭错误和警告高亮功能，0表示关闭
  let g:ycm_enable_diagnostic_signs = 0
  "高亮显示代码中与诊断信息有关的文本或代码，0表示关闭
  let g:ycm_enable_diagnostic_highlighting = 0
  "当光标移到所在行时显示诊断信息
  let g:ycm_echo_current_diagnostic = 1
  "诊断信息过滤器，此选项控制YCM将呈现哪些诊断，针对特定文件类型，用正则表达式控制要显示的内容，用level控制消息的级别，{}表示显示所有诊断信息
  let g:ycm_filter_diagnostics={}
  "每次获取新诊断数据时自动填充位置列表，1表示打开，默认关闭以免干扰可能已放置在位置列表中的其他数据。在vim中用:help location-list命令查看位置列表的具体解释
  let g:ycm_always_populate_location_list = 0
  "在强制编译后自动打位置列表并用诊断信息填充，所谓位置列表就是标出各错误或警告对应在哪些行的小窗口，可以实现直接跳转到错误行
  let g:ycm_open_loclist_on_ycm_diags = 1
  "此选项控制在文件中检测到错误或警告时向用户显示的最大诊断数
  let g:ycm_max_diagnostics_to_display = 100000
  "设置YCM的日志记录级别，可以是debug，info，warning，error或critical。debug是最详细的
  let g:ycm_server_log_level = 'debug'
  "指定OmniSharp server的监视端口，0表示使用os自动提供的未使用的端口
  let g:ycm_csharp_server_port = 0
" }}}

"vim-signify =================================================================== {{{
  let g:signify_vcs_list = [ 'git', 'svn' ]
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
" }}}

" gundo =================================================================== {{{
  nnoremap <Leader>u :GundoToggle<CR>
  if(has('python3'))
      let g:gundo_prefer_python3 = 1
  endif
" }}}

" tabular =================================================================== {{{
  "代码对齐
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a/ :Tabularize /\/\/<CR>
  vmap <Leader>a/ :Tabularize /\/\/<CR>
  nmap <Leader>a  :Tabularize /
  vmap <Leader>a  :Tabularize /
" }}}

" vim-easymotion =================================================================== {{{
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
" }}}

" ale =================================================================== {{{
  "始终开启标志列
  let g:ale_sig_column_always = 0
  let g:ale_set_highlights = 1
  "错误提示标识
  let g:ale_sign_error = "E"
  let g:ale_sign_warning = "W"
  "vim自带状态栏中整合ale
  let g:ale_statusline_format = ['XXH  %d','W  %d','OK']
  "显示linter名称,出错或警告等相关信息
  let g:ale_echo_msg_error_str = "E"
  let g:ale_echo_msg_warning_str = "W"
  let g:ale_echo_msg_format = '[%severity%][%code%][%linter%]%s'
  "只有保存时才进行语法检测
  let g:ale_lint_on_text_changed = "never"
  let g:ale_lint_on_insert_leave = 0
  "打开文件时不检查
  let g:ale_lint_on_enter = 1
  "Only run linters named in ale_linters settings.
  let g:ale_linters_explicit = 1
  "保存文件时自动修复文件
  let g:ale_fix_on_save = 0
  " 检查工具设置
  let g:ale_linters = {
  \   'python': ['flake8', 'pylint'],
  \}
  let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E121,E123,E126,E226,E24,E704,W503'
  let g:ale_python_pylint_options = '--max-line-length=120 --disable=C0114,C0115,C0116,W0201,R0902'
  let g:ale_python_autopep8_options = '--max-line-length=120'
  " 修复工具设置
  let g:ale_fixers = {
  \   'python': ['autopep8', 'yapf', 'isort'],
  \}
  "代码补全开关
  let g:ale_completion_enabled = 0
  let g:ale_completion_autoimport = 0

  "格式化
  autocmd FileType python nnoremap <leader>ef  :ALEFix<CR>
  "前、后一个错误或警告
  nmap <Leader>ek <Plug>(ale_previous_wrap)
  nmap <Leader>ej <Plug>(ale_next_wrap)
  "开启／关闭语法检查
  nmap <Leader>ec :ALEToggle<CR>
  "查看详细信息
  nmap <Leader>ed :ALEDetail<CR>
" }}}

" LeaderF =================================================================== {{{
  let g:Lf_UseCache=0
  let g:Lf_UseMemoryCache=0
  let g:Lf_ReverseOrder=1
  let g:Lf_WindowHeight = 0.30
  let g:Lf_DefaultExternalTool='rg'
  let g:Lf_PreviewInPopup = 1
  let g:Lf_HideHelp = 1
  let g:Lf_ShowDevIcons = 0
  let g:Lf_GtagsAutoGenerate = 0
  let g:Lf_RootMarkers = ['.git', '.svn']
  let g:Lf_GtagsAutoGenerate = 1
  let g:Lf_Gtagslabel = 'native-pygments'

  " 搜索文件
  map <leader>lf :LeaderfFile<CR>
  " 搜索buffer
  map <leader>lb :LeaderfBuffer<CR>
  " 搜索历史命令
  map <leader>lc :LeaderfHistoryCmd<CR>
  " 搜索历史查询命令
  map <leader>ls :LeaderfHistorySearch<CR>

  "搜索
  nmap <unique> <leader>ft <Plug>LeaderfRgPrompt
  "搜索光标或选择的word，没有边界
  nmap <unique> <leader>fw <Plug>LeaderfRgCwordLiteralNoBoundary<CR>
  vmap <unique> <leader>fw <Plug>LeaderfRgVisualLiteralNoBoundary<CR>
  "搜索光标或选择的word，有边界
  nmap <unique> <leader>fW <Plug>LeaderfRgCwordLiteralBoundary<CR>
  vmap <unique> <leader>fW <Plug>LeaderfRgVisualLiteralBoundary<CR>

  "手动更新gtags 
  map <F10> :Leaderf gtags --update<CR>

  "搜索当前光标下函数引用，如果搜索结果只有一个则直接跳转。
  noremap <leader>ff :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
  "搜索当前光标下函数定义，如果搜索结果只有一个则直接跳转。
  noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
  "打开上一次gtags搜索窗口。
  noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
  "跳转到下一个搜索结果。
  noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
  "跳转到上一个搜索结果。
  noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

  let g:Lf_WildIgnore = {
          \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','__pycache__','.pytest_cache'],
          \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.py1.stats']
          \}
" }}}

" vim-terminal-help =================================================================== {{{
  let g:terminal_cwd = 2
  let g:terminal_height = 50
  let g:terminal_pos = 'rightbelow'
  if(g:iswindows)
      let g:terminal_shell = (g:git_bash != '') ? g:git_bash : ''
  endif
  let g:terminal_kill = 'term'
  let g:terminal_list = 0
  let g:terminal_fixheight = 1
  let g:terminal_close = 1
" }}}

set wildmenu
set wildmode=full

map <F3> :call CloseAllBuffer()<CR>

iab xdatetime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<CR>
iab xdate <c-r>=strftime("%Y-%m-%d")<CR>

" 取消高亮
nmap <leader>nh :nohl<CR>
