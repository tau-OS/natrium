

build:
    uv run ./build.sh

build-release:
    cp LICENSE.md build/out/
    cp README.md build/out/
    pushd build/out && zip -r ../../natrium-fonts.zip . && popd
