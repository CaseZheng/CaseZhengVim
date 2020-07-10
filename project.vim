if exists('g:loaded_self_project')
    finish
endif

let g:loaded_self_project = 1

function GetRoteInfo()
endfunction

"同步项目文件到远程
function SynFile(type)
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

    if('' == g:remoteName)
        echo '未设置远程地址信息'
        return
    endif

    let s:remote = get(g:remoteInfo, g:remoteName, '')
    if('' == g:remoteName)
        echo '未设置远程地址信息'
        return
    endif

    let s:ip           = get(s:remote, 'ip', '')
    let s:username     = get(s:remote, 'username', '')
    let s:password     = get(s:remote, 'password', '')
    let s:port         = get(s:remote, 'port', '22')
    let s:project_path = get(s:info, 'projectpath', '')
    let s:rawsetting   = get(s:info, 'rawsettings', '')

    if(s:ip=="" || s:username=="" || s:password=="" || s:project_path=="")
        echo 'ip或username或password或项目路径'
        return
    endif

    let s:remotepathsplit = []
    "/root/share/shettle/casezheng/
    let s:remotepath = get(s:remote, 'remotepath', '')
    if(s:remotepath=="")
        echo "远程逻辑不存在"
        return
    endif

    if(strlen(s:project_path) == strridx(s:project_path, "\\")+1)
        let s:project_path = strpart(s:project_path, 0, strridx(s:project_path, "\\"))
    endif

    "asset
    let s:local_dir_name = strpart(s:project_path, strridx(s:project_path, "\\"))
    let s:local_dir_name = substitute(s:local_dir_name, "\\", "", 'g')
    "/root/share/shettle/casezheng/asset
    let s:remotepath = s:remotepath."/".s:local_dir_name
    let s:remote_base_path = s:remotepath."/".s:local_dir_name

    if(a:type=="current")
        echo '只同步当前目录'
        "D:\code\asset\asset_settle
        let s:currentPath = getcwd()
        "D:\code\asset\
        let s:col = stridx(s:currentPath, s:project_path)
        if(s:col!=0)
            echo '当前目录与项目目录不匹配'
            return
        endif
        "asset_settle
        let s:truncated = strpart(s:currentPath, strlen(s:project_path))
        echo "当前目录与项目目录差值：".s:truncated
        "['asset_settle']
        let s:remotepathsplit = split(s:truncated, "\\")
        echo "远程目录理论新建层级："
        for pathsplit in s:remotepathsplit
            echo pathsplit
        endfor
        "/root/share/shettle/casezheng/asset/asset_settle
        let s:remotepath = s:remotepath.s:truncated
        let s:remotepath = substitute(s:remotepath, "\\", "/", 'g')
        echo "远程目录：".s:remotepath
        let s:project_path = s:currentPath
    else
        echo "全量同步"
    endif

    let s:dirmask    = get(s:info, "dirmask", '')
    let s:filemask   = "|*.git;*.svn;*.vscode;*.vsdx;cscope.*;*git/;*svn/;*vscode/;*.xlsx;*.xls;*.pptx;*.ppt;*.docx;*.doc;GPATH;GTAGS;GRTAGS"
    let s:commmsg = "!start WinSCP.exe /console /command   "
    let s:commmsg = s:commmsg . "  \"option batch on\"   "
    let s:commmsg = s:commmsg . "  \"option confirm off\"   "
    let s:commmsg = s:commmsg . "  \"option echo off\"   "
    let s:commmsg = s:commmsg . "  \"open sftp://".s:username.":".s:password."@".s:ip.":".s:port." -rawsettings ".s:rawsetting."\"   "
    if(a:type=="current")
        "/root/share/shettle/casezheng/asset
        let s:mkdirremotepath = s:remote_base_path
        for pathsplit in s:remotepathsplit
            let s:mkdirremotepath = s:mkdirremotepath."/".pathsplit
            let s:commmsg = s:commmsg . "  \"mkdir ".s:mkdirremotepath."\" "
        endfor
    endif
    let s:commmsg = s:commmsg . "  \"option transfer binary\"  "
    let s:commmsg = s:commmsg . "  \"synchronize remote ".s:project_path." ".s:remotepath." -delete -criteria=time -filemask=".s:filemask."\" "
    let s:commmsg = s:commmsg . "  \"close\"  "
    let s:commmsg = s:commmsg . "  \"exit\"  "
    echom s:commmsg
    silent! execute s:commmsg
    call setreg('+', s:remotepath)
    echo 'success'
endfunction

"同步项目中单个文件到远程
function SendFileToServer()
    silent :w
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

    if('' == g:remoteName)
        echo '未设置远程地址信息'
        return
    endif

    let s:remote = get(g:remoteInfo, g:remoteName, '')
    if('' == g:remoteName)
        echo '未设置远程地址信息'
        return
    endif

    let s:ip           = get(s:remote, 'ip', '')
    let s:username     = get(s:remote, 'username', '')
    let s:password     = get(s:remote, 'password', '')
    let s:port         = get(s:remote, 'port', '22')
    let s:project_path = get(s:info, 'projectpath', '')
    let s:rawsetting   = get(s:info, 'rawsettings', '')

    if(s:ip=="" || s:username=="" || s:password=="" || s:project_path=="")
        echo 'ip或username或password或项目路径'
        return
    endif

    let s:remotepathsplit = []
    "/root/share/shettle/casezheng/
    let s:remotepath = get(s:remote, 'remotepath', '')
    if(s:remotepath=="")
        echo "远程逻辑不存在"
        return
    endif

    if(strlen(s:project_path) == strridx(s:project_path, "\\")+1)
        let s:project_path = strpart(s:project_path, 0, strridx(s:project_path, "\\"))
    endif

    "asset
    let s:local_dir_name = strpart(s:project_path, strridx(s:project_path, "\\"))
    let s:local_dir_name = substitute(s:local_dir_name, "\\", "", 'g')
    "/root/share/shettle/casezheng/asset
    let s:remotepath = s:remotepath."/".s:local_dir_name
    echo "远程项目路径：".s:remotepath

    "D:\code\asset\asset_settle\src\asset.cpp
    let s:file_path = expand("%:p")                             "获得当前文件的路径 包括文件名
    echo "上传文件：".s:file_path
    "D:/code/asset
    let s:project_path = substitute(s:project_path, '\', '/', "g")
    "echo s:project_path
    "/asset_settle/src/asset.cpp
    let s:relativedir = substitute(substitute(s:file_path, '\', '/', "g"), s:project_path, '', "")    "取出具体文件名 保留路径
    "echo s:relativedir
    "/root/share/settle/casezheng/asset/asset_settle/src/asset.cpp
    let s:remotepath = s:remotepath.s:relativedir
    echo "远程文件：".s:remotepath
    let s:commmsg = "!start WinSCP.exe /console /command   "
    let s:commmsg = s:commmsg . "  \"option batch on\"   "
    let s:commmsg = s:commmsg . "  \"option confirm off\"   "
    let s:commmsg = s:commmsg . "  \"option echo off\"   "
    let s:commmsg = s:commmsg . "  \"open sftp://".s:username.":".s:password."@".s:ip.":".s:port." -rawsettings ".s:rawsetting."\"   "
    let s:commmsg = s:commmsg . "  \"option transfer binary\"  "
    let s:commmsg = s:commmsg . "  \"put " . s:file_path . " " . s:remotepath . "\"  "
    let s:commmsg = s:commmsg . "  \"close\"  "
    let s:commmsg = s:commmsg . "  \"exit\"  "
    echom s:commmsg
    silent! execute s:commmsg
endfunction

au BufEnter * command! -buffer -nargs=* UU call SynFile(<f-args>)
au BufEnter * command! -buffer UP call SynFile("")
au BufEnter * command! -buffer UW call SynFile("current")
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

    let s:remote = get(s:info, 'remote', '')
    if('' != s:remote)
        let g:remoteName = s:remote
    endif

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
