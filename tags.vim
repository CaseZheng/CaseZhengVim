if exists('g:loaded_self_tags')
    finish
endif

let g:loaded_self_tags = 1

"重置cscope连接
function ResetCscope()
    silent! execute "cs kill -1"
    if filereadable("cscope.out")
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
    else
        call delete("./"."cscope.tags")
        call delete("./"."cscope.files")
        call delete("./"."cscope.out")
        call delete("./"."cscope.out")
        call delete("./"."cscope.in.out")
        call delete("./"."cscope.po.out")
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
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            " 会自动查找当前目录的cscope.files文件
            silent! execute "!cscope -b -k"  
        else
            silent! execute "!cscope -b -k"
        endif
    endif
    call ResetCscope()
    call ResetYcm()
    :redr!
endfunction
