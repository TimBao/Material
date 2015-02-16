#! /usr/bin/env python

# Author:Tim
# Date:2012-11-23
# CSDN name: goof

import os
import re
import sys
import time
import string
import urllib2
#from BeautifulSoup import BeautifulSoup
from bs4 import BeautifulSoup

# create root dir base on time
path = os.getcwd() + os.sep + time.strftime("%Y_%m_%d", time.localtime())
if not os.path.exists(path):
    os.mkdir(path)

# bolg's name
baseurl = 'http://blog.csdn.net'
if len(sys.argv) < 2:
    print "You shoud input blog's user."
    #sys.exit()
    user = 'goof'
else:
    user = sys.argv[1]

# csdn blog need user-agent for simulate browser
i_headers = {"User-Agent": "Mozilla/5.0 (Windows; U; Windows NT 6.0; zh-CN; rv:1.9.1) Gecko/20090624 Firefox/3.5"}

not_letters_or_digits = u'!"#%\'()*,-./:;<=>?@[\]^_`{|}~ \n\r'
translate_table = dict((ord(char), u'') for char in not_letters_or_digits)
pat = re.compile('href="([^"]*)"')
pat2 = re.compile('(link_title)')

category = {}

def requestPage(url, headers):
    req = urllib2.Request(url, headers=headers)
    return urllib2.urlopen(req)

def getAllLinks():
    mainpage = requestPage(baseurl+'/'+user, i_headers)
    soup = BeautifulSoup(mainpage.read().decode('utf8'))
    return soup.findAll('a')

def getAllCategorys(links):
    for item in links:
        m = pat.search(str(item))
        if m != None:
            h = re.search(r'article/category', str(m.group(1)))
            if h != None:
                categoryName = BeautifulSoup(str(item))
                category[categoryName.a.string] = m.group(1)

def createCategoryDir(name):
    subpath = path + os.sep + name.translate(translate_table)
    if not os.path.exists(subpath):
        os.mkdir(subpath)
    return subpath

def createPage(name, data):
    if os.path.isfile(name):
        print "file: %s exits." % name
        return
    print "backup file: %s" % name
    article = open(name, 'w')
    article.write(data)
    article.close()

def getAllArticles(articles):
    titles = articles.findAll('span')
    for item in titles:
        detail = pat2.search(str(item))
        if detail != None:
            url = pat.search(str(item))
            if url != None:
                page = requestPage(baseurl+url.group(1), i_headers)
                name = BeautifulSoup(str(item))
                nameList=name.findAll(text=True)
                #print nameList
                newname=unicode(nameList[-1])
                #print newname.strip()
                #print "<<---"
                #filename = categorypath + os.sep + name.a.string.translate(translate_table) + ".html"
                filename = categorypath + os.sep + newname.strip() + ".html"
                createPage(filename, page.read())

if __name__ == '__main__':
    links = getAllLinks()
    getAllCategorys(links)

    for key in category.keys():
        categorypath = createCategoryDir(key)
        print categorypath
        page = requestPage(category[key], i_headers)
        articles = BeautifulSoup(page.read().decode('utf8'))
        getAllArticles(articles)

        #get page list num and urls
        titles = articles.findAll('div', 'pagelist')
        for item in titles:
            pagelist = BeautifulSoup(str(item))
            for i in pagelist.findAll('a'):
                if i != None:
                    link = BeautifulSoup(str(i))
                    if link.a.string.isdigit():
                        page = requestPage(baseurl+link.a['href'], i_headers)
                        articles = BeautifulSoup(page.read().decode('utf8'))
                        getAllArticles(articles)

    print "Backup finish."
