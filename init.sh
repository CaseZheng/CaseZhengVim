#!/bin/sh

# cmkae3
if type cmake3 >/dev/null 2>&1; then 
  echo 'exists cmake3' 
else 
  echo 'no exists cmake3' 
  yum install cmake3 -y
fi

# python3
if type python3 >/dev/null 2>&1; then 
  echo 'exists python3' 
else 
  echo 'no exists python3' 
  yum install python3 python3-devel -y
fi

# vim 插件defx依赖
if pip3 show pynvim >/dev/null 2>&1; then 
  echo 'exists pynvim' 
else
  echo 'no exists pynvim' 
  pip3 install --user pynvim
fi

# vim 插件LeaderF依赖
if type rg >/dev/null 2>&1; then 
  echo 'exists rg' 
else 
  echo 'no exists rg' 
  yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
  yum install ripgrep -y
fi

# gtags
if type gtags >/dev/null 2>&1; then 
  echo 'exists gtags' 
else 
  echo 'no exists gtags' 
  wget https://ftp.gnu.org/pub/gnu/global/global-6.6.8.tar.gz
  tar zxvf global-6.6.8.tar.gz
  cd global-6.6.8 && ./configure && make -j8 && make install && cd ../ && rm global-6.6.8* -rf
fi

# scl
if type scl >/dev/null 2>&1; then 
  echo 'exists scl' 
else 
  echo 'no exists scl' 
  yum install centos-release-scl devtoolset-8 -y
fi


wget https://mirrors.tuna.tsinghua.edu.cn/gnu/libc/glibc-2.35.tar.gz
tar zxvf glibc-2.35.tar.gz && cd glibc-2.35 && mkdir -p build && cd build && ../configure  --prefix=/usr --disable-profile --enable-add-ons --with-headers=/usr/include --with-binutils=/usr/bin --disable-sanity-checks --disable-werror && make -j8 && make install && cd ../.. && rm glibc-2.35* -rf

# YoucompleteMe
