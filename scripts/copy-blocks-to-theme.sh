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
cd "$DIR/.."
DIR_PATH=$PWD

# Nhập tên giao diện
while true; do
  read -rp "Nhập tên giao diện: " THEME_NAME
  THEME_PATH="$DIR_PATH/src/themes/$THEME_NAME"
  if [ -d "$THEME_PATH" ]; then
    break
  else
    echo "Giao diện không tồn tại, vui lòng nhập lại."
  fi
done

# Quét các module
for MODULE_DIR in "$DIR_PATH"/src/modules/*; do
  if [ -d "$MODULE_DIR/blocks" ]; then
    MODULE_NAME=$(basename "$MODULE_DIR")
    THEME_MODULE_PATH="$THEME_PATH/modules/$MODULE_NAME"
    mkdir -p "$THEME_MODULE_PATH"

    # Duyệt các tệp .php và .json trong thư mục blocks
    for FILE in "$MODULE_DIR/blocks"/*.{php,json}; do
      [ -e "$FILE" ] || continue # Bỏ qua nếu không có tệp nào phù hợp
      FILE_NAME=$(basename "$FILE")
      TARGET_FILE="$THEME_MODULE_PATH/$FILE_NAME"

      if [ ! -f "$TARGET_FILE" ]; then
        cp "$FILE" "$TARGET_FILE"
        echo "Đã sao chép: $FILE -> $TARGET_FILE"
      fi
    done
  fi

  # Sao chép theme.php
  if [ -f "$MODULE_DIR/theme.php" ]; then
    MODULE_NAME=$(basename "$MODULE_DIR")
    THEME_MODULE_PATH="$THEME_PATH/modules/$MODULE_NAME"
    mkdir -p "$THEME_MODULE_PATH"

    if [ ! -f "$THEME_MODULE_PATH/theme.php" ]; then
      cp "$MODULE_DIR/theme.php" "$THEME_MODULE_PATH/theme.php"
      echo "Đã sao chép: $MODULE_DIR/theme.php -> $THEME_MODULE_PATH/theme.php"
    fi
  fi
done

echo "Hoàn thành."
