#!/bin/sh

# shell补全
if type _init_completion >/dev/null 2>&1; then 
  echo 'exists bash-completion' 
else 
  yum install bash-completion -y
  echo 'source /usr/share/bash-completion/bash_completion' >> ~/.bashrc
fi

# cmkae3
if type cmake3 >/dev/null 2>&1; then 
  echo 'exists cmake3' 
else 
  yum install cmake3 -y
fi

# python3
if type python3 >/dev/null 2>&1; then 
  echo 'exists python3' 
else 
  yum install python3 python3-devel -y
fi

# vim 插件defx依赖
if pip3 show pynvim >/dev/null 2>&1; then 
  echo 'exists pynvim' 
else
  pip3 install --user pynvim
fi

# vim 插件LeaderF依赖
if type rg >/dev/null 2>&1; then 
  echo 'exists rg' 
else 
  yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  yum install ripgrep -y
fi

# gtags
if type gtags >/dev/null 2>&1; then 
  echo 'exists gtags' 
else 
  wget https://ftp.gnu.org/pub/gnu/global/global-6.6.8.tar.gz
  tar zxvf global-6.6.8.tar.gz
  cd global-6.6.8 && ./configure && make -j8 && make install && cd ../ && rm global-6.6.8* -rf
fi

# vim
if type vim >/dev/null 2>&1; then 
  echo 'exists vim' 
else 
  git clone https://github.com/vim/vim.git vim
  cd vim && ./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/lib64/python3.6/config-3.6m-x86_64-linux-gnu --enable-cscope --enable-gui=auto --enable-gtk2-check --enable-fontset --enable-largefile --disable-netbeans --enable-fail-if-missing --prefix=/usr/local && make -j8 && make install && cd ../ && rm vim -rf
  ln -s /usr/local/bin/vim /usr/bin/vim
fi

# locate
if type locate >/dev/null 2>&1; then 
  echo 'exists locate' 
else
  yum install mlocate -y
fi

# go
if type go >/dev/null 2>&1; then 
  echo 'exists go' 
else
  yum install golang -y
fi

# scl
if type scl >/dev/null 2>&1; then 
  echo 'exists scl' 
else 
  yum install scl-utils -y
fi

# sshpass
if type sshpass >/dev/null 2>&1; then 
  echo 'exists sshpass'
else 
  yum install sshpass -y
fi


# YoucompleteMe
if [[ -f "plugged/YouCompleteMe/third_party/ycmd/third_party/clangd/output/bin/clangd" ]]; then 
  echo 'exists clagnd' 
else
  cd plugged/YouCompleteMe && python3 install.py --clangd-completer --go-completer --force-sudo && cd ../../
fi


# tmux
if type tmux >/dev/null 2>&1; then 
  echo 'exists tmux' 
else 
  yum install libevent-devel -y
  git clone https://github.com/tmux/tmux.git
  cd tmux && sh autogen.sh && ./configure && make -j8 && make install; rm tmux -rf && cd ..
fi

# 
