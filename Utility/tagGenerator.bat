REM generator tags for vim

set CURRENT_PATH=
set BRANCH=
set ABPAL=
set ABSERVICE=
set CORESERVICE=
set NBPAL=
set NBSERVICE=
set NBUI=
set PROJECT_PATH=%ABPAL% %ABSERVICE%

ctags -R -o $vim/vimfiles/ctags/code_tags --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q PROJECT_PATH
