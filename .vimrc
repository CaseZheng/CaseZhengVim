let $vimrcpath = expand("~/").".vim/myvimrc.vim"
let $project = expand("~/").".project.vim"

let g:projectName = ''
let g:projectInfo = {}

source $vimrcpath

if filereadable($project)
    source $project
endif

