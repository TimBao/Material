#! bin/bash

CURRENT_PATH=
BRANCH=
PROJECT_PATH=

ctags -R -o ~/.vim/ctags/code_tags --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q PROJECT_PATH
