function ResetCscope(cscope, youcompleteme)
    if(1==a:cscope && executable('cscope') && has("cscope") )
        silent! execute "cs kill -1"
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
    endif
    if 1 == a:youcompleteme
        execute(":YcmRestartServer")
    endif
endfunction

function Do_CsTag()
    let dir = getcwd()
    let s:tagsdeleted=0
    let s:csfilesdeleted=0
    let s:csoutdeleted=0
    echohl WarningMsg | echo dir | echohl None
    if filereadable("cscope.tags")
        if(g:iswindows==1)
            let s:tagsdeleted=delete(dir."\\"."cscope.tags")
        else
            let s:tagsdeleted=delete("./"."cscope.tags")
        endif
        if(s:tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
        return
        endif
    endif
    
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let s:csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let s:csfilesdeleted=delete("./"."cscope.files")
        endif
        if(s:csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let s:csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let s:csoutdeleted=delete("./"."cscope.out")
        endif
        if(s:csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif

    if(g:iswindows!=1)
        let s:command_msg = "!find $(pwd)"
        let s:command_msg = s:command_msg . " -name '*.h'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.hpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.c'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.cpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.inl' -print -o"
        let s:command_msg = s:command_msg . " -name '*.cc'  -print -o"
        let s:command_msg = s:command_msg . " -name '*.py'  -print"
        let s:command_msg = s:command_msg . " > cscope.files"
        silent! execute s:command_msg
    else
        let s:command_msg = "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.inl "
        let s:command_msg = s:command_msg . " > cscope.files"
        silent! execute s:command_msg
    endif
    if(executable('ctags'))
        if(g:iswindows!=1)
            silent! execute "!ctags -f cscope.tags -L cscope.files --c++-kinds=+p --c-kinds=+p --fields=+nmKiaftl --extra=+fq --languages=C++,C,Python,Make,Sh,Lua,Vim  --langmap=c++:+.inl"
        else
            silent! execute "!start /b ctags  -f cscope.tags -L cscope.files --c++-kinds=+p --c-kinds=+p --fields=+nmKiaftl --extra=+fq --languages=C++,C,Python,Make,Sh,Lua,Vim  --langmap=c++:+.inl"
        endif
    else
        echohl WarningMsg | echo "Fail ctags" | echohl None
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            " 会自动查找当前目录的cscope.files文件
            silent! execute "!cscope -b -q -k"  
        else
            silent! execute "!cscope -b -k"
        endif
        call ResetCscope(1, 1)
    endif
    :redr!
endfunction

if (g:iswindows == 1)
    function SynFile(ignore, current)
        if(g:projectName == "")
            echo "未打开任何项目"
            return
        endif
        let s:info = get(g:projectInfo, g:projectName, '')
        if(1 == type(s:info) && '' == s:info)
            echo '项目: '.g:projectName.' 不存在'
            return
        endif
        if(a:ignore!="0" && a:ignore!="1")
            echo '传递参数错误 0:不忽略目录 1:忽略目录'
        endif
        echo "ignore:".a:ignore
        let s:ip         = get(s:info, 'ip', '')
        let s:username   = get(s:info, 'username', '')
        let s:password   = get(s:info, 'password', '')
        let s:port       = get(s:info, 'port', '22')
        let s:localpath  = get(s:info, 'projectpath', '')
        let s:remotepath = get(s:info, 'remotepath', '')
        if(a:current=="1")  "只同步当前目录
            echo '只同步当前目录'
            let s:currentPath = getcwd()
            let s:col = stridx(s:currentPath, s:localpath)
            if(s:col!=0)
                echo '当前目录与项目目录不匹配'
                return
            endif
            let s:truncated = strpart(s:currentPath, strlen(s:localpath))
            let s:remotepath = s:remotepath.s:truncated
            let s:remotepath = substitute(s:remotepath, "\\", "/", 'g')
            let s:localpath = s:currentPath
        endif
        let s:dirmask    = get(s:info, "dirmask", '')
        if(s:ip=="" || s:username=="" || s:password=="" || s:localpath=="" || s:remotepath=="")
            echo 'ip或username或password或项目路径或远程逻辑不存在'
            return
        endif
        let s:filemask   = "|*.git;*.svn;*.vscode;*.vsdx;cscope.*;*git/;*svn/;*vscode/;*.xlsx;*.xls;*.pptx;*.ppt;*.docx;*.doc;"
        if(a:ignore == "1" && type(dirmask) == 3)
            echo '忽略目录:'.string(dirmask)
            for diritem in dirmask
                echo diritem
                let s:filemask = s:filemask . "*" . diritem . "/;"
            endfor
        endif
        let s:commmsg = "!start WinSCP.exe /console /command   "
        let s:commmsg = s:commmsg . "  \"option batch on\"   "
        let s:commmsg = s:commmsg . "  \"option confirm off\"   "
        let s:commmsg = s:commmsg . "  \"option echo off\"   "
        let s:commmsg = s:commmsg . "  \"open sftp://".s:username.":".s:password."@".s:ip.":".s:port."\"   "
        let s:commmsg = s:commmsg . "  \"option transfer binary\"  "
        let s:commmsg = s:commmsg . "  \"synchronize remote ".s:localpath." ".s:remotepath." -delete -criteria=time -filemask=".s:filemask."\" "
        let s:commmsg = s:commmsg . "  \"close\"  "
        let s:commmsg = s:commmsg . "  \"exit\"  "
        echom s:commmsg
        silent! execute s:commmsg
        call setreg('+', s:remotepath)
        echo 'success'
    endfunction

    au BufEnter * command! -buffer -nargs=* UU call SynFile(<f-args>)
    au BufEnter * command! -buffer UP call SynFile("0", "0")
    au BufEnter * command! -buffer UI call SynFile("1", "0")
    au BufEnter * command! -buffer UW call SynFile("0", "1")

    function SendFileToServer()
        "silent :set fileencoding=utf-8
        silent :w
        if(g:projectName == "")
            echo "未打开任何项目"
            return
        endif
        let s:info = get(g:projectInfo, g:projectName, '')
        if(1 == type(s:info) && '' == s:info)
            echo '项目: '.g:projectName.' 不存在'
            return
        endif
        let s:ip         = get(s:info, 'ip', '')
        let s:username   = get(s:info, 'username', '')
        let s:password   = get(s:info, 'password', '')
        let s:port       = get(s:info, 'port', '22')
        let s:localdir  = get(s:info, 'projectpath', '')
        let s:remotepath = get(s:info, 'remotepath', '')
        if(s:ip=="" || s:username=="" || s:password=="" || s:localdir=="" || s:remotepath=="")
            echo 'ip或username或password或项目路径或远程逻辑不存在'
            return
        endif

        let s:localpath = expand("%:p")                             "获得当前文件的路径 包括文件名
        echo s:localpath
        let s:localdir = substitute(s:localdir, '\', '/', "g")
        "echo s:localdir
        let s:relativedir = substitute(substitute(s:localpath, '\', '/', "g"), s:localdir, '', "")    "取出具体文件名 保留路径
        "echo s:relativedir
        let s:remotepath = s:remotepath.s:relativedir
        echo s:remotepath
        let s:commmsg = "!start WinSCP.exe /console /command   "
        let s:commmsg = s:commmsg . "  \"option batch on\"   "
        let s:commmsg = s:commmsg . "  \"option confirm off\"   "
        let s:commmsg = s:commmsg . "  \"option echo off\"   "
        let s:commmsg = s:commmsg . "  \"open ".s:username.":".s:password."@".s:ip.":".s:port."\"   "
        let s:commmsg = s:commmsg . "  \"option transfer binary\"  "
        let s:commmsg = s:commmsg . "  \"put " . s:localpath . " " . s:remotepath . "\"  "
        let s:commmsg = s:commmsg . "  \"close\"  "
        let s:commmsg = s:commmsg . "  \"exit\"  "
        echom s:commmsg
        silent! execute s:commmsg
    endfunction

    au BufEnter * command! -buffer W call SendFileToServer()
endif

function ProjectList()
    echo "项目列表:"
    for item in items(g:projectInfo)
        echo ' '
        echohl WarningMsg | echo "项目名称：" . item[0] . " 项目地址：" . get(item[1], "projectpath", "") . " 描述：" . get(item[1], "desc", "") | echohl NONE
        echo "Ycm：" . get(item[1], "youcompleteme", "0") . " Cscope：" . get(item[1], "cscope", "0") . " 远程IP：" . get(item[1], "ip", "") . " 远程目录：" . get(item[1], "remotepath", "")
    endfor
endfunction

function ProjectInfo()
    if(g:projectName == "")
        echohl ErrorMsg | echo "未打开任何项目" | echohl NONE
        return
    endif
    let s:info = get(g:projectInfo, g:projectName, '')
    if(1 == type(s:info) && '' == s:info)
        echohl ErrorMsg | echo '项目: '.g:projectName.' 不存在' | echohl NONE
        return
    endif
    echo g:projectName
    echo s:info
endfunction

function ProjectOpen(name)
    let s:info = get(g:projectInfo, a:name, '')
    if(1 == type(s:info) && '' == s:info)
        echohl ErrorMsg | echo '项目：'.a:name.' 不存在' | echohl NONE
        call ProjectList()
        return
    endif
    let s:projectpath = get(s:info, 'projectpath', '')
    if('' == s:projectpath)
        echo '项目: '.a:name.' 项目路径不存在'
        call ProjectList()
        return
    endif
    let s:dirmask    = get(s:info, "dirmask", [])
    for diritem in s:dirmask
        call add(g:ctrlsf_ignore_dir, diritem)
    endfor

    let g:projectName = a:name
    silent! execute(":cd ".s:projectpath)
    silent! execute(":e ~/.vim/dirs/tmp/未命名")
    silent! only "只剩余一个窗口
    call CloseAllBuffer()
    execute(":NERDTree")
    let s:tags_files = get(s:info, 'tags', 0)
    if s:tags_files != 0
        set tags+=s:tags_files
    endif
    call ResetCscope(get(s:info, 'cscope', 0), get(s:info, 'youcompleteme', 0))
    echo 'file: '.expand('%').', cwd: '.getcwd().', lines: '.line('$')
    let &titlestring=a:name
    set titlestring+=@%F
endfunction

function ProjectEdit()
    if filewritable($project)
        silent! execute(":e ".$project)
        silent! execute(":source ".$project)
    else
        echohl ErrorMsg | echo '项目文件'.$project'不存在'
    endif
endfunction

function CloseAllBuffer()
    let s:bufferlist = getbufinfo()
	let s:currentbufnr = bufnr("%")
	"echo currentbufnr
    for bufferinfo in s:bufferlist
        if s:currentbufnr == bufferinfo.bufnr 
            continue
        endif
        if 0 == bufferinfo.listed
            continue 
        endif
        "echo 'bufferinfo.hidden'.bufferinfo.hidden
        "echo 'bufferinfo.listed'.bufferinfo.listed
        execute(":bw ".bufferinfo.bufnr)
    endfor
endfunction

au BufEnter * command! -buffer PE call ProjectEdit()
au BufEnter * command! -buffer PL call ProjectList()
au BufEnter * command! -buffer PI call ProjectInfo()
au BufEnter * command! -buffer -nargs=1 PO call ProjectOpen(<f-args>)

function DuplicateRemoval()
    execute(':g/^\(.*\)$\n\1$/d')
endfunction

au BufEnter * command! -buffer UNIQ call DuplicateRemoval()

if (g:iswindows == 1)
    au BufEnter * command! -buffer GIT silent! execute "!start git-bash.exe --cd=".getcwd()
    au BufEnter * command! -buffer CD silent! execute "!start explorer ".getcwd()
    if(executable('powershell'))
        au BufEnter * command! -buffer CMD silent! execute "!start powershell.exe"
    else
        au BufEnter * command! -buffer CMD silent! execute "!start cmd.exe"
    endif
endif


function PrintKeyMap()
    echo "           # F1            # vim帮助文档                # F2        # 打开并强制刷新NERD目录   # F3   # 关闭所有的buffer"
    echo "           # F4            # 打开/关闭tags目录          # F5        # 打开按键帮助             # F6   # C/C++代码 cpp文件与h文件切换"
    echo "           # F7            #                            # F8        #                          # F9   # "
    echo "           # F10           # cscope tags 重新生成       # F11       # 重新启动cscope           # F12  # "
    echo "           #               #                            #           #                          #      # "
    echo "项目       # :PO           # 打开项目                   # :PL       # 项目列表                 # :PE  # 项目编辑"
    echo "           # :PI           # 展示当前项目信息           #           #                          #      # "
    echo "           # :UP           # 同步当前项目到远程         # :UW       # 同步项目的当前目录到远程 # :UI  # 同步项目的当前目录到远程(忽略设定的目录)"
    echo "           # :W            # 将项目的当前文件同步到远程 #           #                          #      # "
    echo "           #               #                            #           #                          #      # "
    echo "注释       # ,dd           # 文档注释                   # ,dd       # 函数/类注释              #      # "
    echo "           # ,cc           # 注释当前行或选中行         # ,ca       # 转换注释方式             # ,cu  # 取消注释"
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
endfunction
