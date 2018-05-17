#!/bin/bash

# This script is automatically triggered by Travis CI
# for any recipe that has been updated on master.

build_zip() {

  echo build_zip $1, $2
  dest=`pwd`/$2
  (cd $1 && zip -r $dest *)
}

check_zip() {
  if [[ `dirname $1` == '.' ]]; then
    zip=`basename $1`
  else
    zip=`dirname $1`_`basename $1`
  fi

  mkdir -p dist

  dest=dist/${zip}

  #echo "check_zip" $1, $dist, $zip, $dest
  if [ ! -f ${dest}.zip ]; then
    build_zip $1 $dest
  else
    result=`find $1 -newer ${dest}.zip`
    #echo $result
    if [ ! -z "$result" ]; then
      build_zip $1 $dest
    fi
  fi
}

find_recipes() {
  for f in `find . -path ./lib -prune -o -name 'app' -print`
  do
    # echo `dirname $f | sed -e 's#./##'`
    check_zip `dirname $f | sed -e 's#./##'`
  done
}

find_recipes
