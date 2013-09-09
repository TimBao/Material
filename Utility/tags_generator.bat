@ECHO OFF

set CWD=%cd%

cd /d %~dp0

set PARENT_PATH=..\..\
set VIM_TAG_PATH="C:\Program Files (x86)\Vim\vimfiles\ctags\code_tags"

set PAL=%PARENT_PATH%pal

ECHO start to generate tags
ctags -R -o %VIM_TAG_PATH% --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q %PAL%
ECHO finish.

cd %CWD%
