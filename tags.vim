if exists('g:loaded_self_tags')
    finish
endif

let g:loaded_self_tags = 1

"重置cscope连接
function ResetCscope()
    silent! execute "cs kill -1"
    "优先使用gtags-cscope
    if executable('gtags-cscope') && filereadable("GTAGS")
        silent! execute "cs add GTAGS"
    elseif filereadable("cscope.out")
        silent! execute "cs add cscope.out"
    endif
endfunction

"重启YoucompleteMe
function ResetYcm()
    silent! execute(":YcmRestartServer")
endfunction

"重置Cscope和Ycm
function ResetTags()
    call ResetCscope()
    call ResetYcm()
endfunction

"生成项目索引文件
function GenTags()
    let dir = getcwd()

    if has("cscope")
        silent! execute "cs kill -1"
    endif

    if(g:iswindows==1)
        call delete(dir."\\"."cscope.tags")
        call delete(dir."\\"."cscope.files")
        call delete(dir."\\"."ncscope.out")
        call delete(dir."\\"."cscope.out")
        call delete(dir."\\"."cscope.in.out")
        call delete(dir."\\"."cscope.po.out")
        call delete(dir."\\"."GPATH")
        call delete(dir."\\"."GRTAGS")
        call delete(dir."\\"."GTAGS")
    else
        call delete("./"."cscope.tags")
        call delete("./"."cscope.files")
        call delete("./"."cscope.out")
        call delete("./"."cscope.out")
        call delete("./"."cscope.in.out")
        call delete("./"."cscope.po.out")
        call delete("./"."GPATH")
        call delete("./"."GRTAGS")
        call delete("./"."GTAGS")
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
    else
        let s:command_msg = "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.inl "
        let s:command_msg = s:command_msg . " > cscope.files"
    endif
    if(executable('gtags-cscope') && has("cscope"))
        let s:command_msg = s:command_msg . " & gtags -f cscope.files"
    elseif(executable('cscope') && has("cscope"))
        let s:command_msg = s:command_msg . " & cscope -b -k"
    endif
    silent! execute s:command_msg
    call ResetTags()
    :redr!
endfunction

"保存时自动更新tags文件
function GtagsAutoUpdate()
    if executable('global') && filereadable("GTAGS")
        call system("global -u --single-update=\"" . expand("%") . "\"")
    endif
endfunction
autocmd! BufWritePost * call GtagsAutoUpdate()
