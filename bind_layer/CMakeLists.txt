# CMakeLists.txt
cmake_minimum_required(VERSION 3.13)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)
project(bind_layer C CXX ASM)
pico_sdk_init()

add_library(bind_layer STATIC
    blink.c
)
target_link_libraries(bind_layer pico_stdlib)