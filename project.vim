if exists('g:loaded_self_project')
    finish
endif

let g:loaded_self_project = 1

"同步项目文件到远程
function SynFile(type)
    if(g:project_name == "")
        echo "未打开任何项目"
        return
    endif

    let s:info = get(g:project_conf_info, g:project_name, '')
    if(1 == type(s:info) && '' == s:info)
        echo '项目: '.g:project_name.' 不存在'
        return
    endif

    if('' == g:remote_name)
        echo '未设置远程地址信息'
        return
    endif

    let s:remote = get(g:remote_conf_info, g:remote_name, '')
    if('' == g:remote_name)
        echo '未设置远程地址信息'
        return
    endif

    let s:ip           = get(s:remote, 'ip', '')
    let s:username     = get(s:remote, 'username', '')
    let s:password     = get(s:remote, 'password', '')
    let s:port         = get(s:remote, 'port', '22')
    let s:project_path = get(s:info, 'projectpath', '')
    let s:remotepath   = get(s:remote, 'remotepath', '')

    if(s:ip=="" || s:username=="" || s:password=="" || s:project_path=="" || s:remotepath=="")
        echo 'ip或username或password或项目路径或远程目录 为空'
        return
    endif

    let s:exclude = ""
    let s:exclude = s:exclude . "--exclude '.git'"
    let s:exclude = s:exclude . " --exclude '.svn'"

    let s:pro_exclude = get(s:info, "exclude", [])
    for item in s:pro_exclude
      let s:exclude = s:exclude . " --exclude '".item."'"
    endfor

    let s:cmd = "sshpass -p".s:password." rsync -e 'ssh -p".s:port."' -ar --delete --ignore-errors -p ".s:exclude." ".s:project_path." ".s:username."@".s:ip.":".s:remotepath."&"
    echo s:cmd
    execute('!'.s:cmd)
endfunction

au BufEnter * command! -buffer UP call SynFile("")
au BufEnter * command! -buffer UW call SynFile("current")

"打印项目列表
function ProjectList()
    echo "项目列表:"
    for item in items(g:project_conf_info)
        echo ' '
        echohl WarningMsg | echo "项目名称：" . item[0] . " 项目地址：" . get(item[1], "projectpath", "") . " 描述：" . get(item[1], "desc", "") | echohl NONE
        echo "Ycm：" . get(item[1], "ycm", "0") . " 远程IP：" . get(item[1], "ip", "") . " 远程目录：" . get(item[1], "remotepath", "")
    endfor
endfunction

"打印项目信息
function ProjectInfo()
    if(g:project_name == "")
        echohl ErrorMsg | echo "未打开任何项目" | echohl NONE
        return
    endif
    let s:info = get(g:project_conf_info, g:project_name, '')
    if(1 == type(s:info) && '' == s:info)
        echohl ErrorMsg | echo '项目: '.g:project_name.' 不存在' | echohl NONE
        return
    endif
    echo g:project_name
    echo s:info
endfunction

"重启YoucompleteMe
function ResetYcm()
    silent! execute(":YcmRestartServer")
endfunction

"打开项目
function ProjectOpen(name)
    let s:info = get(g:project_conf_info, a:name, '')
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

    let s:remote = get(s:info, 'remote', '')
    if('' != s:remote)
        let g:remote_name = s:remote
    endif

    let g:project_name = a:name
    silent! execute(":cd ".s:projectpath)
    silent! only "只剩余一个窗口
    call CloseAllBuffer()
    execute(":Defx ./")
    echo 'file: '.expand('%').', cwd: '.getcwd().', lines: '.line('$')
    let &titlestring=a:name
    set titlestring+=@%F
endfunction

"编辑项目配置文件
function ProjectEdit()
    if filewritable($project_conf_path)
        silent! execute(":e ".$project_conf_path)
        silent! execute(":source ".$project_conf_path)
    else
        echohl ErrorMsg | echo '项目文件'.$project_conf_path'不存在'
    endif
endfunction

au BufEnter * command! -buffer PE call ProjectEdit()
au BufEnter * command! -buffer PL call ProjectList()
au BufEnter * command! -buffer PI call ProjectInfo()
au BufEnter * command! -buffer -nargs=1 PO call ProjectOpen(<f-args>)
