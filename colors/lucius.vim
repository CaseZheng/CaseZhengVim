" Lucius vim color file
  " Maintainer:   Jonathan Filip <jfilip1024@gmail.com>
  " Version: 3.5
  
  " UPDATE by Chiyl
  " Maintainer:   Lawrence Chi <xidiandaily@126.com>
  " Version: 3.6
  
  set background=dark
  hi clear
  if exists("syntax_on")
      syntax reset
  endif
  let colors_name="lucius"
  
  
  " == Normal color 正常文本==
  hi Normal           guifg=#eeeeee           guibg=#1c1c1c 
  hi Normal           ctermfg=255             ctermbg=234
  
  
  " == Comments 注释==
  hi Comment          guifg=#a8a8a8                                   gui=none
  hi Comment          ctermfg=248                                     cterm=none
  
  
  " == Constants 常量==
  " any constant
  hi Constant         guifg=#ff0087                                   gui=none
  hi Constant         ctermfg=198                                      cterm=none
  " strings 字符串
  hi String           guifg=#ffffff                                   gui=none
  hi String           ctermfg=231                                    cterm=none
  " character constant 字符常数
  hi Character        guifg=#87afdf                                   gui=none
  hi Character        ctermfg=110                                     cterm=none
  " numbers decimal/hex 十六进制数 小数
  hi Number           guifg=#ffaf00                                   gui=none
  hi Number           ctermfg=214                                     cterm=none
  " true, false
  hi Boolean          guifg=#00af00                                   gui=none
  hi Boolean          ctermfg=34                                      cterm=none
  " float       浮点数
  hi Float            guifg=#ffaf00                                   gui=none
  hi Float            ctermfg=214                                      cterm=none
  
  
  " == Identifiers 标识符==
  " any variable name 任何变量名
  hi Identifier       guifg=#df005f                                   gui=none 
  hi Identifier       ctermfg=161                                     cterm=none
  " function, method, class 函数 方法 类
  hi Function         guifg=#df0087                                   gui=none 
  hi Function         ctermfg=162                                     cterm=none
  
  
  " == Statements 声明==
  " any statement 任何声明
  hi Statement        guifg=#ffff00                                   gui=none
  hi Statement        ctermfg=226                                     cterm=none
  " if, then, else
  hi Conditional      guifg=#ffff00                                   gui=none
  hi Conditional      ctermfg=226                                     cterm=none
  " try, catch, throw, raise
  hi Exception        guifg=#ffff00                                   gui=none
  hi Exception        ctermfg=226   cterm=none
  " for, while, do
  hi Repeat           guifg=#ffff00                                   gui=none
  hi Repeat           ctermfg=226   cterm=none
  " case, default
  hi Label            guifg=#ffff00                                   gui=none
  hi Label            ctermfg=226   cterm=none
  " sizeof, +, *
  hi Operator         guifg=#ffff00                                   gui=none
  hi Operator         ctermfg=226   cterm=none
  " any other keyword
  hi Keyword          guifg=#ffff00                                   gui=none
  hi Keyword          ctermfg=226   cterm=none
  
  
  " == Preprocessor 预处理 ==
  " generic preprocessor 通用的预处理
  hi PreProc          guifg=#00df00                                   gui=none
  hi PreProc          ctermfg=40                                     cterm=none
  " #include
  hi Include          guifg=#00df00                                   gui=none
  hi Include          ctermfg=40                                     cterm=none
  " #define
  hi Define           guifg=#00df00                                   gui=none
  hi Define           ctermfg=40                                     cterm=none
  " same as define
  hi Macro            guifg=#00df00                                   gui=none
  hi Macro            ctermfg=40                                     cterm=none
  " #if, #else, #endif
  hi PreCondit        guifg=#00df00                                   gui=none
  hi PreCondit        ctermfg=40                                     cterm=none
  
  
  " == Types 类型==
  " int, long, char
  hi Type             guifg=#5fff5f                                   gui=none
  hi Type             ctermfg=83                                     cterm=none
  " static, register, volative
  hi StorageClass     guifg=#5fff5f                                   gui=none
  hi StorageClass     ctermfg=83                                     cterm=none
  " struct, union, enum
  hi Structure        guifg=#5fff5f                                   gui=none
  hi Structure        ctermfg=83                                     cterm=none
  " typedef
  hi Typedef          guifg=#5fff5f                                   gui=none
  hi Typedef          ctermfg=83                                     cterm=none
  
  
  " == Special ==
  " any special symbol 所有特殊符号
  hi Special          guifg=#ff5f00                                   gui=none
  hi Special          ctermfg=202                                     cterm=none
  " special character in a constant
  hi SpecialChar      guifg=#ff5f00                                 gui=none
  hi SpecialChar      ctermfg=202                                   cterm=none
  " things you can CTRL-]
  hi Tag              guifg=#ff5f00                             gui=none
  hi Tag              ctermfg=202                             cterm=none
  " character that needs attention
  hi Delimiter        guifg=#ff5f00                             gui=none
  hi Delimiter        ctermfg=202                             cterm=none
  " special things inside a comment
  hi SpecialComment   guifg=#ff5f00                             gui=none
  hi SpecialComment   ctermfg=202                             cterm=none
  " debugging statements
  hi Debug            guifg=#ff5f00                             gui=none
  hi Debug            ctermfg=202                             cterm=none
  
  
  " == Text Markup 文本标记==
  " text that stands out, html links 文本突出 HTMML链接
  hi Underlined       guifg=fg                                        gui=underline
  hi Underlined       ctermfg=fg                                      cterm=underline
  " any erroneous construct 任何错误
  hi Error            guifg=#df5f5f           guibg=#606060           gui=none
  hi Error            ctermfg=167             ctermbg=241            cterm=none
  " todo, fixme, note, xxx
  hi Todo             guifg=#dfdf87           guibg=NONE              gui=underline
  hi Todo             ctermfg=186             ctermbg=NONE            cterm=underline
  " match parenthesis, brackets 匹配括号 括号
  hi MatchParen       guifg=#00ff00           guibg=NONE              gui=bold
  hi MatchParen       ctermfg=46              ctermbg=NONE            cterm=bold
  " the '~' and '@' and showbreak, '>' double wide char doesn't fit on line
  hi NonText          guifg=#585858                                   gui=none
  hi NonText          ctermfg=240                                     cterm=none
  " meta and special keys used with map, unprintable characters 不可打印字符
  hi SpecialKey       guifg=#c6c6c6
  hi SpecialKey       ctermfg=251
  " titles for output from :set all, :autocmd, etc 输出的命令
  hi Title            guifg=#5fafdf                                   gui=bold
  hi Title            ctermfg=74                                      cterm=bold
  
  
  " == Ignore ==
  " left blank, hidden
  hi Ignore           guifg=bg
  hi Ignore           ctermfg=bg
  
  
  " == Text Selection 文本选择==
  " character under the cursor 光标下字符
  hi Cursor           guifg=bg                guibg=#afdfff
  hi Cursor           ctermfg=bg             ctermbg=153
  " like cursor, but used when in IME mode  在IME模式下使用连接光标
  hi CursorIM         guifg=bg                guibg=#87dfdf
  hi CursorIM         ctermfg=bg              ctermbg=116
  " cursor column 光标行
  hi CursorColumn     guifg=NONE              guibg=#444444           gui=none
  hi CursorColumn     ctermfg=NONE            ctermbg=238             cterm=none
  " cursor line/row 光标列
  hi CursorLine       gui=NONE                guibg=#444444           gui=none
  hi CursorLine       cterm=NONE              ctermbg=238             cterm=none
  " visual mode selection 选择模式
  hi Visual           guifg=NONE              guibg=#005f87
  hi Visual           ctermfg=NONE            ctermbg=24
  " visual mode selection when vim is not owning the selection (x11 only)
  hi VisualNOS        guifg=fg                                        gui=underline
  hi VisualNOS        ctermfg=fg                                      cterm=underline
  " highlight incremental search text; also highlight text replaced with :s///c
  hi IncSearch        guifg=#5fffff                                   gui=reverse
  hi IncSearch        ctermfg=87                                      cterm=reverse
  " hlsearch (last search pattern), also used for quickfix
  hi Search                                    guibg=#ffdf87          gui=none
  hi Search                                    ctermbg=222            cterm=none
  
  
  " == UI ==
  " normal item in popup 弹出的item
  hi Pmenu            guifg=#dadada           guibg=#4e4e4e           gui=none
  hi Pmenu            ctermfg=253             ctermbg=239             cterm=none
  " selected item in popup 弹出中选中的item
  hi PmenuSel         guifg=#dfdf87           guibg=#3a3a3a           gui=none
  hi PmenuSel         ctermfg=186             ctermbg=237             cterm=none
  " scrollbar in popup 弹出窗口中的滚动条
  hi PMenuSbar                                guibg=#5f5f5f           gui=none
  hi PMenuSbar                                ctermbg=59              cterm=none
  " thumb of the scrollbar in the popup
  hi PMenuThumb                               guibg=#808890           gui=none
  hi PMenuThumb                               ctermbg=102             cterm=none
  " status line for current window
  hi StatusLine       guifg=#e0e0e0           guibg=#363946           gui=bold
  hi StatusLine       ctermfg=254             ctermbg=237             cterm=bold
  " status line for non-current windows
  hi StatusLineNC     guifg=#767986           guibg=#363946           gui=none
  hi StatusLineNC     ctermfg=244             ctermbg=237             cterm=none
  " tab pages line, not active tab page label
  hi TabLine          guifg=#b6bf98           guibg=#363946           gui=none
  hi TabLine          ctermfg=244             ctermbg=236             cterm=none
  " tab pages line, where there are no labels
  hi TabLineFill      guifg=#cfcfaf           guibg=#363946           gui=none
  hi TabLineFill      ctermfg=187             ctermbg=236             cterm=none
  " tab pages line, active tab page label
  hi TabLineSel       guifg=#efefef           guibg=#414658           gui=bold
  hi TabLineSel       ctermfg=254             ctermbg=236             cterm=bold
  " column separating vertically split windows
  hi VertSplit        guifg=#777777           guibg=#363946           gui=none
  hi VertSplit        ctermfg=242             ctermbg=237             cterm=none
  " line used for closed folds
  hi Folded           guifg=#d0e0f0           guibg=#202020           gui=none
  hi Folded           ctermfg=117             ctermbg=235             cterm=none
  " column on side used to indicated open and closed folds
  hi FoldColumn       guifg=#c0c0d0           guibg=#363946           gui=none
  hi FoldColumn       ctermfg=117             ctermbg=238             cterm=none
  
  
  " == Spelling ==
  " word not recognized 拼写错误
  hi SpellBad         guisp=#ff0000                                   gui=undercurl
  hi SpellBad                                 ctermbg=196             cterm=undercurl
  " word not capitalized
  hi SpellCap         guisp=#ffff00                                   gui=undercurl
  hi SpellCap                                 ctermbg=226             cterm=undercurl
  " rare word
  hi SpellRare        guisp=#ffaf00                                   gui=undercurl
  hi SpellRare                                ctermbg=214             cterm=undercurl
  " wrong spelling for selected region
  hi SpellLocal       guisp=#ffaf00                                   gui=undercurl
  hi SpellLocal                               ctermbg=214             cterm=undercurl
  
  
  " == Diff ==
  " added line 新加行
  hi DiffAdd          guifg=fg           guibg=#005f00           gui=none
  hi DiffAdd          ctermfg=fg              ctermbg=22              cterm=none
  " changed line 改变行
  hi DiffChange       guifg=fg              guibg=#5f0000           gui=none
  hi DiffChange       ctermfg=fg              ctermbg=52              cterm=none
  " deleted line 删除行
  hi DiffDelete       guifg=fg           guibg=#5f5f00           gui=none
  hi DiffDelete       ctermfg=fg              ctermbg=58              cterm=none
  " changed text within line 行中更改文本
  hi DiffText         guifg=#ff5f5f           guibg=#5f0000           gui=bold
  hi DiffText         ctermfg=203             ctermbg=52              cterm=bold
  
  
  " == Misc 杂项==
  " directory names and other special names in listings 列表中的目录名称和其他特殊名称
  hi Directory        guifg=#af00ff                                   gui=none
  hi Directory        ctermfg=129                                     cterm=none
  " error messages on the command line 命令行上错误信息
  hi ErrorMsg         guifg=#ff0000           guibg=NONE              gui=none
  hi ErrorMsg         ctermfg=196             ctermbg=NONE            cterm=none
  " columns where signs are displayed (used in IDEs) 纵向标志显示（用于ide）
  hi SignColumn       guifg=#afafaf           guibg=#121212           gui=none
  hi SignColumn       ctermfg=145             ctermbg=233             cterm=none
  " line numbers 行号
  hi LineNr           guifg=#ff0000           guibg=#121212
  hi LineNr           ctermfg=196             ctermbg=233
  " the 'more' prompt when output takes more than one line 当输出超过一行时，“更多”提示
  hi MoreMsg          guifg=#00875f                                   gui=none
  hi MoreMsg          ctermfg=29                                      cterm=none
  " text showing what mode you are in 显示当前模式的文字
  hi ModeMsg          guifg=#87dfff           guibg=NONE              gui=none
  hi ModeMsg          ctermfg=117             ctermbg=NONE            cterm=none
  " the hit-enter prompt (show more output) and yes/no questions 命中输入提示符（显示更多输出）和Yes /否问题
  hi Question         guifg=fg                                        gui=none
  hi Question         ctermfg=fg                                      cterm=none
  " warning messages 警告信息
  hi WarningMsg       guifg=#df5f5f                                   gui=none
  hi WarningMsg       ctermfg=167                                     cterm=none
  " current match in the wildmenu completion
  hi WildMenu         guifg=#afffaf           guibg=#585858           gui=bold,underline
  hi WildMenu         ctermfg=157              ctermbg=240             cterm=bold,underline
  " color column highlighting 纵行高亮
  hi ColorColumn      guifg=NONE              guibg=#875f5f           gui=none
  hi ColorColumn      ctermfg=NONE            ctermbg=95              cterm=none
  
  " == Vimwiki Colors Vimwiki颜色==
  
  hi VimwikiHeader1   guifg=#dfdfaf                                   gui=bold
  hi VimWikiHeader1   ctermfg=187                                     cterm=bold
  hi VimwikiHeader2   guifg=#87afdf                                   gui=bold
  hi VimwikiHeader2   ctermfg=110                                     cterm=bold
  hi VimwikiHeader3   guifg=#afdf87                                   gui=bold
  hi VimwikiHeader3   ctermfg=150                                     cterm=bold
  hi VimwikiHeader4   guifg=#87dfdf                                   gui=bold 
  hi VimwikiHeader4   ctermfg=116                                     cterm=bold
  hi VimwikiHeader5   guifg=#dfafdf                                   gui=bold
  hi VimwikiHeader5   ctermfg=182                                     cterm=bold
  hi VimwikiHeader6   guifg=#87dfaf                                   gui=bold
  hi VimwikiHeader6   ctermfg=115                                     cterm=none

  let g:indent_guides_auto_colors = 0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermfg=237 ctermbg=236 guifg=#303030 guibg= #3a3a3a
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermfg=236 ctermbg=237 guifg=#303030 guibg= #3a3a3a
