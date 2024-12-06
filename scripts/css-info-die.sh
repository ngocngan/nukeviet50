#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    SOURCE="$DIR/$TARGET"
  fi
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
cd "$DIR/.."
DIR_PATH=$PWD

sass --style compressed --no-source-map scss/core/info_die.scss:scripts/info_die.css

CSS_CONTENT=$(<"${DIR_PATH}/scripts/info_die.css")
sed -i 's|<style>.*</style>|<style>'"$CSS_CONTENT"'</style>|g' $DIR_PATH/src/themes/future/system/info_die.tpl
rm -f "${DIR_PATH}/scripts/info_die.css"

echo "Done!"
