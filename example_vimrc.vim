let $vimrc_path = 'D:\vim_conf\vimrc.vim'
let $project_conf_path = 'D:\vim_conf\project_conf.vim'

let g:vim_conf_path = 'D:\vim_conf\'
let g:project_name = ''
let g:project_info = {}
let g:git_bash = 'C:\Program Files\Git\bin\bash.exe'

source $vimrc_path

if filereadable($project_conf_path)
    source $project_conf_path
endif
