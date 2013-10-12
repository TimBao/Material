#!/bin/bash

CURRENT_PATH=.

DB_PATH=~/.vim/CSCOPEDB
if [ -d "$DB_PATH" ]; then
   rm -rf $DB_PATH
fi
mkdir $DB_PATH

CSCOPE_FILE=cscope.files
echo "Create file map : " $CSCOPE_FILE
find $CURRENT_PATH -name "*.h" -o -name "*.c" -o -name "*.cpp" > $DB_PATH/$CSCOPE_FILE
cscope -bkq -i $DB_PATH/$CSCOPE_FILE
mv cscope.* $DB_PATH
echo "Cscope database is generated."
