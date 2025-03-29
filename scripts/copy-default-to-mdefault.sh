#!/bin/bash

# Đặt thư mục gốc
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$(dirname "$SOURCE")"
    SOURCE="$DIR/$TARGET"
  fi
done
DIR="$(cd -P "$(dirname "$SOURCE")" >/dev/null 2>&1 && pwd)"
cd "$DIR/../src"
DIR_PATH=$PWD

for MODULE_DIR in "$DIR_PATH"/themes/default/modules/*; do
  if [ -d "$MODULE_DIR" ]; then
    MODULE_NAME=$(basename "$MODULE_DIR")

    # Chép tpl, không chép đè
    TARGET_DIR="$DIR_PATH/themes/mobile_default/modules/$MODULE_NAME"
    mkdir -p "$TARGET_DIR"

    find "$MODULE_DIR" -mindepth 1 -print | while read SRC_PATH; do
      RELATIVE_PATH="${SRC_PATH#$MODULE_DIR/}"
      DEST_PATH="$TARGET_DIR/$RELATIVE_PATH"

      if [ ! -e "$DEST_PATH" ]; then
        if [ -d "$SRC_PATH" ]; then
          # Nếu là thư mục và chưa tồn tại, thì tạo thư mục
          mkdir -p "$DEST_PATH"
          echo "Tạo thư mục: $DEST_PATH"
        else
          # Nếu là file và chưa tồn tại, thì sao chép file
          cp "$SRC_PATH" "$DEST_PATH"
          echo "Sao chép file: $SRC_PATH -> $DEST_PATH"
        fi
      fi
    done

    # Chép JS
    if [ ! -f "$DIR_PATH/themes/mobile_default/js/${MODULE_NAME}.js" ] && [ -f "$DIR_PATH/themes/default/js/${MODULE_NAME}.js" ] ; then
      cp "$DIR_PATH/themes/default/js/${MODULE_NAME}.js" "$DIR_PATH/themes/mobile_default/js/${MODULE_NAME}.js"
      echo "Đã sao chép: js/${MODULE_NAME}.js"
    fi
  fi
done

echo "Hoàn thành."
