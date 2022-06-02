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
    function OpenBash()
        let s:cmd="!start ".g:git_bash." --cd=".getcwd()
        silent! execute s:cmd
    endfunction

    au BufEnter * command! -buffer GGIT silent! execute "!start GitExtensions.exe browse ".getcwd()
    au BufEnter * command! -buffer GIT call OpenBash()
    au BufEnter * command! -buffer CD silent! execute "!start explorer ".getcwd()
    if(executable('powershell'))
        au BufEnter * command! -buffer CMD silent! execute "!start powershell.exe"
    else
        au BufEnter * command! -buffer CMD silent! execute "!start cmd.exe"
    endif
endif
