

build:
    uv run ./build.sh

build-release:
    pushd build/out && zip -r ../../natrium-fonts.zip . && popd
