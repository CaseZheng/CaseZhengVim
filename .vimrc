if(has("win32") || has("win95") || has("win64") || has("win16"))
    set shell=C:\windows\system32\cmd.exe
    let g:iswindows = 1
else
	let g:iswindows=0
endif

if(g:iswindows)
	let $vimrcpath = expand("~/.vim/")."myvimrc.vim"
    let $project = expand("~/").".project.vim"

	let $HOMEPATH = expand("~/")
	let $PATH = $PATH.";".$HOMEPATH.".vim/exec/"
else
    let g:ctags_ignore_directory = " -path '/usr/local/include' -prune -o"
    let g:ctags_ignore_directory = g:ctags_ignore_directory . " -path '/usr/include' -prune -o"

	let $vimrcpath = expand("~/").".vim/myvimrc.vim"
    let $project = expand("~/").".project.vim"
endif

let g:projectName = ''
let g:projectInfo = {}

if filereadable($project)
    source $project
endif

source $vimrcpath
