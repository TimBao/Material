#! /bin/sh

echo "purge firefox"
sudo apt-get purge firefox

echo "remove .mozilla/firefox"
if [ -d "~/.mozilla/firefox" ]; then
    rmdir ~/.mozilla/firefox/
fi

echo "remove /etc/firefox"
if [ -d "/etc/firefox" ]; then
    sudo rmdir /etc/firefox/
fi

echo "remove /usr/lib/firefox"
if [ -d "/usr/lib/firefox/" ]; then
    sudo rmdir /usr/lib/firefox/
fi

echo "remove /usr/lib/firefox-addons"
if [ -d "/usr/lib/firefox-addons/" ]; then
    sudo rmdir /usr/lib/firefox-addons/
fi
