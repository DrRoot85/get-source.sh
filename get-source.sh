#!/bin/bash
# cloning the suversion source according to freebsd handbook: 
# https://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/svn.html

# setting svn url for our version of freebsd
base_url='https://svn.freebsd.org/base/releng'
version=$(uname -r | perl -ple 's/-.+//')
svn_url="${base_url}/${version}/"

# svn gets weirded out by the geo-mirroring/dns alias or svnmir.geo.freebsd.org, so
# lets add it to the hosts file 

grep svn.freebsd.org /etc/hosts || host svnmir.geo.freebsd.org | head -n 1 | awk '{print $NF, "\tsvn.freebsd.org"}' >>/etc/hosts
svnlite info $svn_url || exit 1
svnlite co $svn_url /usr/src

