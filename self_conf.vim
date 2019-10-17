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
    if filereadable("tags")
        if(g:iswindows==1)
            let s:tagsdeleted=delete(dir."\\"."tags")
        else
            let s:tagsdeleted=delete("./"."tags")
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
    if filereadable("you.files")
        if(g:iswindows==1)
            let s:csfilesdeleted=delete(dir."\\"."you.files")
        else
            let s:csfilesdeleted=delete("./"."you.files")
        endif
        if(s:csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the you.files" | echohl None
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
        let s:command_msg = "!find $(pwd)" . g:ctags_ignore_directory
        let s:command_msg = s:command_msg . " -name '*.h'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.hpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.c'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.cpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.inl' -print -o"
        let s:command_msg = s:command_msg . " -name '*.cc'  -print -o"
        let s:command_msg = s:command_msg . " -name '*.py'  -print"
        let s:command_msg = s:command_msg . " > cscope.files"
        silent! execute s:command_msg
        let s:command_msg = "!find $(pwd)"
        let s:command_msg = s:command_msg . " -name '*.h'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.hpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.c'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.cpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.inl' -print -o"
        let s:command_msg = s:command_msg . " -name '*.cc'  -print -o"
        let s:command_msg = s:command_msg . " -name '*.py'  -print"
        let s:command_msg = s:command_msg . " > you.files"
        silent! execute s:command_msg
    else
        let s:command_msg = "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.inl "
        let s:command_msg = s:command_msg . g:ctags_ignore_directory
        let s:command_msg = s:command_msg . " > cscope.files"
        silent! execute s:command_msg
        let s:command_msg = "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.inl "
        let s:command_msg = s:command_msg . " > you.files"
        silent! execute s:command_msg

    endif
    if(executable('ctags'))
        if(g:iswindows!=1)
            silent! execute "!ctags -L cscope.files --c++-kinds=+p --c-kinds=+p --fields=+nmKiaftl --extra=+fq --languages=C++,C,Python,Make,Sh,Lua,Vim  --langmap=c++:+.inl"
        else
            silent! execute "!start ctags -L cscope.files --c++-kinds=+p --c-kinds=+p --fields=+nmKiaftl --extra=+fq --languages=C++,C,Python,Make,Sh,Lua,Vim  --langmap=c++:+.inl"
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

    au BufEnter * command! -buffer GIT silent! execute "!start git-bash.exe --cd=".getcwd()
    au BufEnter * command! -buffer CD silent! execute "!start explorer ".getcwd()

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
        let s:filemask   = "|*.git;*.svn;*.vscode;cscope.files;you.files;cscope.out;tags;*git/;*svn/;*vscode/;*.xlsx;*.xls;*.pptx;*.ppt;*.docx;*.doc;"
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
        echo s:commmsg
        silent! execute s:commmsg
        call setreg('+', s:remotepath)
        echo 'success'
    endfunction

    au BufEnter * command! -buffer -nargs=* UU call SynFile(<f-args>)
    au BufEnter * command! -buffer UP call SynFile("0", "0")
    au BufEnter * command! -buffer UI call SynFile("1", "0")
    au BufEnter * command! -buffer UW call SynFile("0", "1")

    function SendFileToServer()
        silent :set fileencoding=utf-8
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
        echo s:commmsg
        silent! execute s:commmsg

    endfunction

    au BufEnter * command! -buffer W call SendFileToServer()
endif

function ProjectList()
    echo "项目列表:"
    for item in items(g:projectInfo)
        echo ' '
        echohl WarningMsg | echo "项目名称：" . item[0] . " 项目地址：" . get(item[1], "projectpath", "") | echohl NONE
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
    silent! execute(":e [未命名]")
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

function PrintKeyMap()
    echo "F1 vim帮助文档            F2 打开并强制刷新NERD目录           F3                              F4 打开/关闭tags目录"
    echo "F5                        F6 C/C++代码 cpp文件与h文件切换     F7                              F8 "
    echo "                          F10 cscope tags 重新生成            F11 重新启动cscope              F12 "
    echo "项目                      :PO 打开项目                        :PL 项目列表"
    echo "注释                      ,dd 文档注释                        ,dd 函数/类注释"
    echo "文件查找                  ,lf"
    echo "打开当前文件在NERD的位置  ,t"
    echo "git变更跳转               ,gj 下一个变更                      ,gk 上一个变更"
    echo "                          ,gJ 最后一个变更                    ,gK 第一个变更                  ,gl 变更大概情况"
    echo "窗口跳转                  ("
    echo "buffer跳转                ,1 ,2 ,3 ... ...                    ,- 上一个                       ,+ 下一个"
    echo "cscope搜索                Ctrl-_ s 搜索                       "
    echo "Quickfix跳转              ,qc 查看当前浏览的行信息            ,qj 查看下一个                  ,qk 查看上一个"
    echo "                          ,ql 查看所有                        ,qo 打开窗口                    ,qc 关闭窗口"
    echo "Tab                       ,tl 打开/关闭tab管理窗口            ,tf 将光标移动到tab管理窗口" 
    echo "对齐                      ,a= 按=对齐                         ,a: 按:对齐                     ,a/ 按/对齐"
    echo "搜索                      ,ffc ctrlsf搜索"
    echo "注释                      ,cc 注释当前行和选中行              ,cm 使用一对注释符注释          ,ci 有则取消，无则添加"
    echo "                          ,cy 注释选中部分                    ,cu 取消注释                    ,c$ 注释光标当行尾"
    echo "撤销和恢复                ,u 撤销和恢复原先的记录"
    echo "上传代码到远程            :W 将当前文件双传到远程(Windows 有效)"
    "echo "MarkDown Tac生成          :GenTocGFM 新建                     :UpdateToc 更新                 :RemoveToc删除"
    echo "插入时间                  插入模式下xdatetime空格 插入日期和时间"
endfunction

function PrintPlantUml()
    echo "类图关系                  继承(类和类) --|>"
    echo "                          实现(类和接口继承) ...|>"
    echo "                          依赖(单向的，局部变量、方法参数、静态方法调用) ...>"
    echo "                          关联(一个类知道另一个类的属性和方法，例如成员变量) 单向 --> 双向 --"
    echo "                          合成(关联关系的特例，整体和部分，两个类一个代表整体，一个代表部分) *-->"
    echo "                          聚合(关联关系的特例，整体和部分，两个类一个代表整体，一个代表部分) o-->"
endfunction

function PrintCscope()
    echo " cscope使用                                               "
    echo " s: 查找C语言符号，即查找函数名、宏、枚举值等出现的地方   "
    echo " g: 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能 "
    echo " d: 查找本函数调用的函数                                  "
    echo " c: 查找调用本函数的函数                                  "
    "echo " t: 查找指定的字符串                                      "
    "echo " e: 查找egrep模式，相当于egrep功能，但查找速度快多了      "
    "echo " f: 查找并打开文件，类似vim的find功能                     "
    "echo " i: 查找包含本文件的文件                                  "
endfunction
