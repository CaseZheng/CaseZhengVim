if exists('g:loaded_self_tags')
    finish
endif

let g:loaded_self_tags = 1

let g:use_gtags=0

if has("cscope")
    "设定cst选项同时搜索cscope数据库和标签文件cscopetag
    set cst
    if executable('gtags-cscope')
        "使用 gtags-cscope 代替 cscope
        set cscopeprg=gtags-cscope
        let g:use_gtags=1
    endif
    "如果csto被设为0,cscope数据库先被搜索,搜索失败的情况下在搜索标签文件.如果csto被设为1,标签文件会在cscope数据库之前被搜索cscopetagorder
    set csto=0
    "添加一个数据库时，显示添加成功或失败
    set csverb
    nmap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>	
endif

"重置cscope连接
function ResetCscope()
    silent! execute "cs kill -1"
    "优先使用gtags-cscope
    if g:use_gtags==1
        if filereadable("GTAGS")
            silent! execute "cs add GTAGS"
        endif
    else
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
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

    if(g:iswindows)
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

    if(g:iswindows)
        let s:command_msg = "!dir /s/b *.c,*.cpp,*.h,*.hpp,*.cc,*.inl "
        let s:command_msg = s:command_msg . " > cscope.files"
    else
        let s:command_msg = "!find $(pwd)"
        let s:command_msg = s:command_msg . " -name '*.h'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.hpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.c'   -print -o"
        let s:command_msg = s:command_msg . " -name '*.cpp' -print -o"
        let s:command_msg = s:command_msg . " -name '*.inl' -print -o"
        let s:command_msg = s:command_msg . " -name '*.cc'  -print -o"
        let s:command_msg = s:command_msg . " -name '*.py'  -print"
        let s:command_msg = s:command_msg . " > cscope.files"

    endif

    if has("cscope")
        if(g:use_gtags==1)
            let s:command_msg = s:command_msg . " & gtags -f cscope.files"
        else
            let s:command_msg = s:command_msg . " & cscope -b -k"
        endif
        silent! execute s:command_msg
    endif
    call ResetTags()
    :redr!
endfunction

"保存时自动更新tags文件
function GtagsAutoUpdate()
    if(g:use_gtags==1 && filereadable("GTAGS"))
        call system("global -u --single-update=\"" . expand("%") . "\"")
    endif
endfunction

autocmd! BufWritePost * call GtagsAutoUpdate()
