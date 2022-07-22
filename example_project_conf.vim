let g:remote_conf_info = {
        \ 'dev_001' : { 'ip' : '1.127.0.1', 'port' : '22',  'username' : 'user',  'password' : 'passwd',  'remotepath' : '/data/home/casezheng/code/', },
    \ }

let g:project_conf_info = {
        \ 'st' : {
            \ 'projectpath' : '/data/code/settle',
            \ 'remote' : 'dev_001',
            \ 'exclude' : ['xxx_test'],
        \ },
        \ 'vim' : {
            \ 'projectpath' : '/data/vim_conf/',
            \ 'exclude' : [],
        \ },
    \ }

let g:remoteName = ''
