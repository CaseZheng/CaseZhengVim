if exists('g:loaded_self_other')
    finish
endif

let g:loaded_self_other = 1

"关闭所有buffer
function CloseAllBuffer()
    silent! execute(":e ~/.vim/dirs/tmp/未命名")
    let s:bufferlist = getbufinfo()
    let s:currentbufnr = bufnr("%")
    for bufferinfo in s:bufferlist
        if s:currentbufnr == bufferinfo.bufnr 
            continue
        endif
        if 0 == bufferinfo.listed
            continue 
        endif
        execute(":bw ".bufferinfo.bufnr)
    endfor
endfunction

"删除重复行
function DuplicateRemoval()
    execute(':g/^\(.*\)$\n\1$/d')
endfunction

au BufEnter * command! -buffer UNIQ call DuplicateRemoval()

"文件编码
function SetFile()
    execute(':set fileencoding=utf8')
    execute(':set fileformat=unix')
    execute(':w')
endfunction

map <F8> :call SetFile()<CR>

if (g:iswindows == 1)
    au BufEnter * command! -buffer GGIT silent! execute "!start GitExtensions.exe browse ".getcwd()
    au BufEnter * command! -buffer GIT silent! execute "!start bash.exe --cd=".getcwd()
    au BufEnter * command! -buffer CD silent! execute "!start explorer ".getcwd()
    if(executable('powershell'))
        au BufEnter * command! -buffer CMD silent! execute "!start powershell.exe"
    else
        au BufEnter * command! -buffer CMD silent! execute "!start cmd.exe"
    endif
endif


"打印常用的快捷键
function PrintKeyMap()
    echo "           # F1            # vim帮助文档                # F2        # 打开并强制刷新NERD目录   # F3   # 关闭所有的buffer"
    echo "           # F4            # 打开/关闭tags目录          # F5        # 打开按键帮助             # F6   # "
    echo "           # F7            #                            # F8        # 文件编码设为UFT8         # F9   # "
    echo "           # F10           # cscope 重新生成            # F11       # 重新启动cscope           # F12  # "
    echo "           #               #                            #           #                          #      # "
    echo "项目       # :PO           # 打开项目                   # :PL       # 项目列表                 # :PE  # 项目编辑"
    echo "           # :PI           # 展示当前项目信息           #           #                          #      # "
    echo "           # :UP           # 同步当前项目到远程         # :UW       # 同步项目的当前目录到远程 # :UI  # 同步项目的当前目录到远程(忽略设定的目录)"
    echo "           # :W            # 将项目的当前文件同步到远程 #           #                          #      # "
    echo "           #               #                            #           #                          #      # "
    echo "注释       # ,cc           # 注释当前行或选中行         # ,ca       # 转换注释方式             # ,cu  # 取消注释"
    echo "           # ,ci           # 有则取消，无则添加         # ,cm       # 使用一对注释符注释       #      # "
    echo "           #               #                            #           #                          #      # "
    echo "查找       # ,lf           # 查找当前目录下的文件       # ,lb       # buffer查看和切换         # ,lc  # vim历史命令"
    echo "           # ,ls           # vim历史搜索记录            #           #                          #      # "
    echo "           # ,ft           # 从当前目录下文件查找内容   # ,fw       # 从当前目录下文件查找内容 # ,fl  # 查看查找结果"
    echo "           #               #                            #           #                          #      # "
    echo "git变更    # ,gj           # 下一个变更                 # ,gk       # 上一个变更               # ,gJ  # 最后一个变更  "
    echo "           # ,gK           # 第一个变更                 #           #                          #      # "
    echo "           #               #                            #           #                          #      # "
    echo "buffer跳转 # ,n            # 跳转到第n个buffer          # ,-        # 上一个buffer             # ,+   # 下一个buffer"
    echo "           #               #                            #           #                          #      # "
    echo "cscope搜索 # ,fs           # 查找C语言符号              # ,fg       # 查找函数、宏等定义的位置 # ,fc  # 查找调用本函数的函数"
    echo "           #               #                            #           #                          #      # "
    echo "对齐       # ,a=           # 按=对齐                    # ,a:       # 按:对齐                  # ,a/  # 按/对齐"
    echo "           #               #                            #           #                          #      # "
    echo "快速跳转   # ,,h           # 同行向左跳转               # ,,l       # 同行向右跳转             # ,,j  # 行间向下跳转"
    echo "           # ,,k           # 行间向上跳转               # ,,w       # 行间向后按单词跳转       # ,,b  # 行间向前按单词跳转"
    echo "           #               #                            #           #                          #      # "
    echo "Tab        # ,tl           # 打开/关闭tab管理窗口       # ,tf       # 将光标移动到tab管理窗口  #      # "
    echo "           #               #                            #           #                          #      # "
    echo "杂项       # (             # 窗口跳转                   # ,u        # 编辑记录查看和复原       # ,nh  # 去除高亮"
    echo "           # xdatetime空格 # 打印%Y-%m-%d %H:%M:%S      # xdate空格 # 打印%Y-%m-%d             #      # "
    echo "           # :UNIQ         # 去除重复行                 #           #                          #      # "
    echo "           # :GIT          # 打开git bash               # :CD       # 打开文档资源管理器       # :CMD # 打开windows自带的cmd或powershell"
    echo "           # :GGIT         # 打开Git Extensions         #"
endfunction
