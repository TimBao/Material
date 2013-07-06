## For Linux
### install autotools
    1.clocal
    1.autoscan
    1.autoconf
    1.autoheader
    1.automake
### ubuntu
    sudo apt-get install autoconf

### Generate Makefile
1.使用autoscan命令
    Autoscan是用来扫描源代码目录生成configure.scan文件的。Autoscan可以用目录名做为参数，但如果你不适用参数的话，那么autoscan将认为使用的是当前目录。Autoscan将扫描你所指定目录中的源文件，并创建configure.scan文件。
    在命令行中执行autoscan命令，如下：
    $autoscan
    已经生成了autoscan.log、configure.scan文件。Configure.scan文件包含了系统配置的基本选项，里面都是一些宏定义。将configure.scan文件修改为configure.in，操作如下：
    $mv configure.scan configure.in
    $vim configure.in
    #                                               -*- Autoconf -*-
    # Process this file with autoconf to produce a configure script.
    AC_PREREQ([2.64])
    AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
    AC_CONFIG_SRCDIR([hello.c])
    #AC_CONFIG_HEADERS([config.h])
    AM_INIT_AUTOMAKE(name,1.0)
    # Checks for programs.
    AC_PROG_CC  #c
    AC_PROG_CXX #c++
    # Checks for libraries.
    # Checks for header files.
    # Checks for typedefs, structures, and compiler characteristics.
    # Checks for library functions.
    AC_OUTPUT(Makefile)
    说明：
    #号表示注释。
    AC_INIT(FILE)
    这个宏用来检查源代码所在的路径。
    AM_INIT_AUTOMAKE(PACKAGE,VERSION)
    这个宏是必须的，它描述了我们将要生成的软件包的名字及其版本号：PACKAGE是软件包的名字，VERSION是版本号。当你使用make dist命令时，它会给你生成一个类似hello-1.0.tar.gz的软件发行包，其中就对应的软件包的名字和版本号。
    AC_PROG_CC
    这个宏将检查系统所用的C编译器
    AC_OUTPUT(FILE)
    这个宏是我们要输出的Makefile的名字。
2.使用aclocal命令
    aclocal是一个perl脚本程序。Aclocal根据configure.in文件的内容，自动生成aclocal.m4文件。
    在命令行中执行aclocal命令，如下：
    $aclocal
    生成aclocal.m4和automte.cache文件
3.使用autoconf命令
    autoconf是用来产生configure文件的。Configure是一个脚本，它能设置源程序来适应各种不同的操作系统平台，并且根据不同的系统来产生合适的Makefile，从而可以使你的源代码能在不同的操作系统平台上被编译出来。
    在命令行中执行autoconf命令，如下：
    $autoconf
    生成configure文件。
4.编写Makefile.am文件
    AUTOMAKE_OPTIONS=foreign
    bin_PROGRAMS=hello
    hello_SOURCES=hello.c
    Makefile.am文件是用来生成Makefile.in的，需要你手工书写。Makefile.in中定义了一些内容：
    AUTOMAKE_OPTIONS
    这个是automake的选项。在执行automake时，它会检查目录下是否存在标准GNU软件包中应具有的各种方法，例如AUTHORS 、ChangeLog 、NEWS 等文件。我们将其设置成foreign 时，automake 会改用一般软件包的标准来检查。
    bin_PROGRAMS
    这个是指定我们所要产生的可执行文件的文件名。如果你要产生多个可执行文件，那么在各个名字间用空格隔开。
    noinst_PROGRAMS
    对于可执行文件和静态库类型，如果只想编译，不想安装到系统中，就可以使用noinst_PROGRAMS代替bin_PROGRAMS，类似地：noinst_LIBRARIES代替lib_LIBRARIES。
    hello_SOURCES
    这个是指定产生“hello” 时所需要的源代码。如果它用到了多个源文件，那么请使用空格符号将它们隔开。比如需要 hello.h ，hello.c 那么请写成hello_SOURCES= hello.h hello.c。
    如果你在bin_PROGRAMS 定义了多个可执行文件，则对应每个可执行文件都要定义相对的filename_SOURCES。
5.使用automake命令
    我们使用automake --add-missing来产生Makefile.in。选项--add-missing 的定义是“add missing standard files to package” ，它会让automake 加入一个标准的软件包所必须的一些文件。
    我们用automake 产生出来的Makefile.in 文件是符合GNU Makefile 惯例的，接下来我们只要执行configure 这个shell 脚本就可以产生合适的 Makefile 文件了。
    在命令行中执行automake命令，如下：
    $automake --add-missing
6.执行configure生成Makefile文件
    $./configure
7.使用Makefile编译代码
    在符合GNU Makefiel 惯例的Makefile 中，包含了一些基本的预先定义的操作：
    Make
    根据Makefile 编译源代码，连接，生成目标文件，可执行文件。
    make clean
    清除上次的make 命令所产生的object 文件（后缀为“.o” 的文件）及可执行文件。
    make install
    将编译成功的可执行文件安装到系统目录中，一般为/usr/local/bin 目录。
    make dist
    产生发布软件包文件（即distribution package ）。这个命令将会将可执行文件及相关文件打包成一个tar.gz 压缩的文件用来作为发布软件的软件包。
    它会在当前目录下生成一个名字类似“PACKAGE-VERSION.tar.gz” 的文件。PACKAGE 和VERSION ，是我们在configure.in 中定义的AM_INIT_AUTOMAKE(PACKAGE, VERSION) 。
    make distcheck
    生成发布软件包并对其进行测试检查，以确定发布包的正确性。这个操作将自动把压缩包文件解开，然后执行configure命令，并且执行make，来确认编译不出现错误，最后提示你软件包已经准备好，可以发布了。
    helloworld-1.0.tar.gz is ready for distribution
    make distclean
    类似makeclean，但同时也将configure生成的文件全部删除掉，包括Makefile。
