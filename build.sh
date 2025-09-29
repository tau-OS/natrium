#!/bin/bash
# run this script inside venv using `uv run ./build.sh`

BUILD_DIR=build
OUT_DIR="$BUILD_DIR/out"

GEIST_VERSION=1.5.1
GEIST_FONT_DIR="$BUILD_DIR/geist-font-${GEIST_VERSION}"

MONO_DIR="${GEIST_FONT_DIR}/fonts/GeistMono"
REGULAR_DIR="${GEIST_FONT_DIR}/fonts/Geist"

FONT_URL="https://github.com/vercel/geist-font/releases/download/${GEIST_VERSION}/geist-font-${GEIST_VERSION}.zip"

mkdir -p $OUT_DIR

subdirs=(
    "otf"
    "ttf"
    "variable"
)

fonts=(
    "Geist"
    "GeistMono"
)

common_args=(
    -v
    -f "ss02,ss04,ss05,ss08,tnum"
    -R 'Geist/Natrium'
    -i
)


function prepare_font() {
    if [ ! -d "$GEIST_FONT_DIR" ]; then
        echo "Downloading Geist Font..."
        curl -L "$FONT_URL" -o "$BUILD_DIR/geist-font.zip"
        unzip "$BUILD_DIR/geist-font.zip" -d "$BUILD_DIR"
        rm "$BUILD_DIR/geist-font.zip"
    fi
}
# Process individual font file
function process_font() {
    local font_file="$1"
    local output_dir="$2"
    local filename=$(basename "$font_file")
    local replaced_filename=$(echo "$filename" | sed 's/Geist/Natrium/g')
    local output_dir=$(echo $output_dir | sed 's/Geist/Natrium/g')
    mkdir -p "$output_dir"
    local output_file="${output_dir}/${replaced_filename}"
    echo "Processing $font_file -> $output_file"
    pyftfeatfreeze "${common_args[@]}" "$font_file" "$output_file"
}

function process_font_set() {
    local font_dir=$1
    local dir_name=$(basename "$font_dir")
    for subdir in "${subdirs[@]}"; do
        local subdir_path="${font_dir}/${subdir}"
        if [ -d "$subdir_path" ]; then
            for font_file in "$subdir_path"/*; do
                echo "Processing $font_file"
                process_font "$font_file" "$OUT_DIR/$dir_name/$subdir"
            done
        fi
    done
}

prepare_font

process_font_set "$GEIST_FONT_DIR/fonts/Geist"
