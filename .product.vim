if(g:iswindows)
    let g:ctags_ignore_directory = " | find \/v \"implements\\boost_lib\" "
endif

let g:projectInfo = {
        \ 'wif' : {
            \ 'projectpath' : 'E:\code\wxsettle_interface_server',  'youcompleteme' : 1,  'cscope' : 1,  'tags' : '',
            \ 'ip' : '127.0.0.1',  'port' : '36000',  'username' : 'casezheng',  'password' : 'casezheng',  'remotepath' : '/data/casezheng/code/wxsettle_interface_server',
            \ 'dirmask' : ['branches'],
        \ },
        \ 'relay' : {
            \ 'projectpath' : 'E:\relay_proxy\',  'youcompleteme' : 1,  'cscope' : 1,
        \ },
        \ 'vim' : {
            \ 'projectpath' : 'C:\Users\casezheng\.vim',
        \ },
        \ 'hexo' : {
            \ 'projectpath' : 'E:\git\BlogSourceCode',
        \ },
    \ }
