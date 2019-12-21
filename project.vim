if exists('g:loaded_self_project')
    finish
endif

let g:loaded_self_project = 1

"同步项目文件到远程
function SynFile(ignore, current)
    if (g:iswindows != 1)
        echo "非windows平台"
        return
    endif
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

"同步项目中单个文件到远程
function SendFileToServer()
    if (g:iswindows != 1)
        echo "非windows平台"
        return
    endif

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

au BufEnter * command! -buffer -nargs=* UU call SynFile(<f-args>)
au BufEnter * command! -buffer UP call SynFile("0", "0")
au BufEnter * command! -buffer UI call SynFile("1", "0")
au BufEnter * command! -buffer UW call SynFile("0", "1")
au BufEnter * command! -buffer W call SendFileToServer()

"打印项目列表
function ProjectList()
    echo "项目列表:"
    for item in items(g:projectInfo)
        echo ' '
        echohl WarningMsg | echo "项目名称：" . item[0] . " 项目地址：" . get(item[1], "projectpath", "") . " 描述：" . get(item[1], "desc", "") | echohl NONE
        echo "Ycm：" . get(item[1], "ycm", "0") . " Cscope：" . get(item[1], "cscope", "0") . " 远程IP：" . get(item[1], "ip", "") . " 远程目录：" . get(item[1], "remotepath", "")
    endfor
endfunction

"打印项目信息
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

"打开项目
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
    silent! only "只剩余一个窗口
    call CloseAllBuffer()
    execute(":NERDTree")
    if(get(s:info, 'cscope', 0) == 1)
        call ResetCscope()
    endif
    if(get(s:info, 'ycm', 0) == 1)
        call ResetYcm()
    endif
    echo 'file: '.expand('%').', cwd: '.getcwd().', lines: '.line('$')
    let &titlestring=a:name
    set titlestring+=@%F
endfunction

"编辑项目配置文件
function ProjectEdit()
    if filewritable($project)
        silent! execute(":e ".$project)
        silent! execute(":source ".$project)
    else
        echohl ErrorMsg | echo '项目文件'.$project'不存在'
    endif
endfunction

au BufEnter * command! -buffer PE call ProjectEdit()
au BufEnter * command! -buffer PL call ProjectList()
au BufEnter * command! -buffer PI call ProjectInfo()
au BufEnter * command! -buffer -nargs=1 PO call ProjectOpen(<f-args>)
