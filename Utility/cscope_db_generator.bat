@echo off
set base_dir=%~dp0

rem cscope need linux sort command for it's -q option
set PATH=c:\cygwin\bin;%PATH%

set DB_PATH="c:\Program Files (x86)\Vim\vimfiles\CSCOPEDB"

if exist %DB_PATH% (
    rmdir /S %DB_PATH%
)
md %DB_PATH%

set CSCOPE_FILE=cscope.files
set ALL_PATH=

echo "Create file map : " %CSCOPE_FILE%
for %%i in (%ALL_PATH%) do (
    cd /d %%i
    for /f %%a in ('dir /b /s *.h') do (
        echo %%a >> %DB_PATH%/%CSCOPE_FILE%
    )
)

cd %base_dir%
cscope -bkq -i %DB_PATH%/%CSCOPE_FILE%
xcopy cscope.* %DB_PATH%

echo Cscope database is generated.
