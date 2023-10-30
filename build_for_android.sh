#!/bin/sh
set -eu

libm_dir=/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android/29

export ZIG_LIBC=./libc.ini
rm -f hello.o
zig cc \
    -target aarch64-linux-android \
    --sysroot=$(zig clang -print-resource-dir)/sysroot \
    hello.zig \
    -dynamic \
    -femulated-tls -mtls-size=64  -mtls-direct-seg-refs \
    -c -o hello.o \
    $@

## zig cc link
# zig ld.lld \
#     --sysroot=/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot \
#     --error-limit=0 \
#     -O0 \
#     -z stack-size=16777216 \
#     --gc-sections \
#     --eh-frame-hdr \
#     -znow \
#     -m aarch64linux \
#     -static \
#     -pie \
#     -dynamic-linker /system/bin/linker64 \
#     -o hello /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android/29/crtbegin_static.o \
#     -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/aarch64 \
#     -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android/29 \
#     -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android \
#     -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib hello.o /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/libclang_rt.builtins-aarch64-android.a \
#     -l:libunwind.a \
#     -ldl \
#     -lc /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/libclang_rt.builtins-aarch64-android.a \
#     -l:libunwind.a \
#     -ldl /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/aarch64/crtend_android.o

## zig clang link
zig ld.lld \
    --sysroot=/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot \
    -pie \
    -EL \
    --fix-cortex-a53-843419 \
    -z now \
    -z relro \
    -z max-page-size=4096 \
    --hash-style=gnu \
    --eh-frame-hdr \
    -m aarch64linux \
    -dynamic-linker /system/bin/linker64 \
    -o hello /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/aarch64/crtbegin_dynamic.o \
    -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/aarch64 \
    -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android/29 \
    -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib/aarch64-linux-android \
    -L/data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/sysroot/usr/lib hello.o /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/libclang_rt.builtins-aarch64-android.a \
    -l:libunwind.a \
    -ldl \
    -lc /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/libclang_rt.builtins-aarch64-android.a \
    -l:libunwind.a \
    -ldl /data/data/green_green_avk.anotherterm.oldgood/usr/local/lib/lib/clang/17/lib/linux/aarch64/crtend_android.o

file ./hello && ./hello
