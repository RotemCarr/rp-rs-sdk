#!/bin/bash

# Run this in the crate root only!
export PICO_SDK_PATH="$(pwd)/pico-sdk"
cd "./bind_layer"
rm -rf build && mkdir build
cd build
cmake .. -DPICO_SDK_PATH=$PICO_SDK_PATH
make clean & make
cd ../..
cargo clean
cargo build --release
cargo run --release
