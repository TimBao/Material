#1. pid list document. (txt)
#2. java document where pid need to replace by #1. (txt)
#3. python script. Do: (1). read #1, 2(replace #2) 3. replay java file. (4) build (5) copy apk to another palce. (6) repeat #1 ~ #5

import os
import shutil
import errno
import subprocess

current_cwd = os.getcwd()
source_dir = os.path.join(current_cwd, "Othello")
txt_file = "StartupActivity.txt"
source_file = "StartupActivity.java"

def delete_dir(src):
    '''delete an entire directory tree'''
    shutil.rmtree(src)

def copy_dir(src, dst):
    try:
       shutil.copytree(src, dst)
    except OSError, e:
        if e.errno == errno.ENOTDIR:
            shutil.copy(s, d)
        else:
            print 'Directory not copied. Error: %s' % e

def copy_file(srcdir, dstfile):
    shutil.copy(dstfile, srcdir)

def main():
    f = open('pid_list.txt', 'r')
    for eachLine in f:
        os.chdir(current_cwd)
        
        #copy file to new folder
        newfolder = os.path.join(current_cwd, eachLine.strip())
        if os.path.exists(newfolder):
            delete_dir(newfolder)

        copy_dir(source_dir, newfolder)

        #remove old java file
        try:
            os.remove(os.path.join(os.path.join(newfolder, "src/com/game/othello"), source_file))
        except OSError:
            pass

        #replace appid
        txtfile = open(os.path.join(os.path.join(newfolder, "src/com/game/othello"), txt_file), 'r')
        destfile = open(os.path.join(os.path.join(newfolder, "src/com/game/othello"), source_file), 'w')
        for line in txtfile.readlines():
            destfile.writelines(line.replace("@pid@", eachLine.strip()))
        txtfile.close()
        destfile.close()
        os.chdir(newfolder)

        #run build script
        cmdStr = ["ant", "release"]
        subprocess.Popen(cmdStr).wait()

    f.close(); 

if __name__ == '__main__':
    main()
