#!/bin/bash
set -e

SOURCE=$1; shift
SHA_SUM=$1; shift

name=$(basename $SOURCE)
sha_check="$SHA_SUM $name"

cd /tmp
wget "$SOURCE"
echo $sha_check | sha256sum -c
cd /usr/src/wordpress/wp-content/plugins
unzip /tmp/$name
rm /tmp/$name
