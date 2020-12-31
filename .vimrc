let $vimrcpath = expand("~/").".vim/myvimrc.vim"
let $project = expand("~/").".project.vim"

let g:projectName = ''
let g:projectInfo = {}
let g:gitBash = 'C:\Program Files\Git\bin\bash.exe'

source $vimrcpath

if filereadable($project)
    source $project
endif
