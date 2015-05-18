# Mac OS X Summary

## Skill

1. Install Homebrwe [http://brew.sh/](http://brew.sh/ "Homebrew")
   1. brew is a usefull tool on Mac OS X platform as apt-get on Ubuntu. Install or Uninstall other tools.
   2. `sudo chown -R $USER:staff /usr/local`
      `ruby -e "$(curl -x 127.0.0.1:8087 -kL https://raw.github.com/mxcl/homebrew/go)"`
      `In china, must use agent to download.`

---
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  6367  100  6367    0     0   2684      0  0:00:02  0:00:02 --:--:--  2685
    ==> This script will install:
    /usr/local/bin/brew
    /usr/local/Library/...
    /usr/local/share/man/man1/brew.1

    Press ENTER to continue or any other key to abort
    ==> Downloading and Installing Homebrew...
    remote: Counting objects: 121580, done.
    remote: Compressing objects: 100% (59159/59159), done.
    remote: Total 121580 (delta 85194), reused 95203 (delta 61451)
    Receiving objects: 100% (121580/121580), 19.22 MiB | 52 KiB/s, done.
    Resolving deltas: 100% (85194/85194), done.
    From https://github.com/mxcl/homebrew
     * [new branch]      master     -> origin/master
    HEAD is now at f6c471d jenkins 1.524
    Warning: Install the "Command Line Tools for Xcode": http://connect.apple.com
    ==> Installation successful!
    You should run `brew doctor' *before* you install anything.
    Now type: brew help


## vimium plugin for google chrome on mac OS X
  A: vimium plugin could not work correctly on mac OS X for chrome?
  Q: use `inspect devices` tools to see the runtime error. Find that the vimium do not have permission to access hosts to get URL from google*.
  So reopen the chrome use sudo to get admistrater priority, it works fine.

2. open source crypt library: libgcrypt
