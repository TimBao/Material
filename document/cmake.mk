##cmake manual

---
cmake plugin for vim/gvim
    cmake-indent.vim
    cmake-syntax.vim
http://www.cmake.org/cmake/resources/software.html

### How to install
1. download latest source of cmake from http://www.cmake.org/cmake/resources/software.html
1. tar zvxf cmake-2.8.11.2.tar.gz
1. cd cmake-2.8.11.2
1. ./configure --prefix=/opt/cmake
1. make
1. make install
1. check /opt/cmake/bin/cmake -version
1. sudo ln -s /opt/cmake/bin/* /usr/bin
