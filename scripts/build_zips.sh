#!/bin/bash

# for any recipe that has been updated
# rebuild the zip file in dist

build_zip() {

  echo build_zip $1, $2, $3
  mkdir -p $2
  dest=`realpath $2`/$3
  (cd $1 && zip -r $dest *)
}

check_zip() {
  dist=dist/`dirname $1`
  zip=`basename $1`
  dest=${dist}/${zip}

  #echo "check_zip" $1, $dist, $zip, $dest
  if [ ! -f ${dest}.zip ]; then
    build_zip $1 $dist $zip $dest
  else
    result=`find $1 -newer ${dest}.zip`
    #echo $result
    if [ ! -z "$result" ]; then
      build_zip $1 $dist $zip $dest
    fi
  fi
}

find_recipes() {
  for f in `find . -name 'app' -type d`
  do
    check_zip `dirname $f | sed -e 's#./##'`
  done
}

find_recipes
