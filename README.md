# Android development on any platform

## For setting up SDK & NDK

Do you want to settting up SDK & NDK to compile android app on any platform?  
Please look into this script [termux_setup_android_dev.sh](termux_setup_android_dev.sh)

On termux, Run this script [termux_setup_android_dev.sh](termux_setup_android_dev.sh) will do that for you.

## For compiling android targeted binary only

Want to know how does this work?  
Please checkout [tests/test_toolchain.sh](tests/test_toolchain.sh)

### Instruction

Get NDK: [google site](https://developer.android.google.com/ndk/downloads) or [github site](https://github.com/android/ndk/releases)

Then run:

```sh
## Unzip android ndk to somewhere
unzip <android_ndk_package>

## Get resouce from ndk
./android-cross-toolchain.sh setup <path_to_ndk_root>
```

Get LLVM

- alpine:`apk add llvm lld`
- [zig](https://ziglang.org/download/):`export ZIG=<path_to_zig>`

- [static-clang](https://github.com/dzbarsky/static-clang/releases), [llvm-project](https://github.com/llvm/llvm-project/releases), [llvmbox](https://github.com/rsms/llvmbox/releases) or other llvm toolchain : `export PATH=${PATH}:<path_to_llvm_bin>`

Test toolchain

```sh
./bin/aarch64-linux-android21-clang tests/hello.c
./bin/aarch64-linux-android21-clang++ tests/hello.cpp
```

## Relavent links

- [Assembling a Complete Toolchain](https://clang.llvm.org/docs/Toolchain.html)
- [llvm-cross-toolchains](https://github.com/shengyun-zhou/llvm-cross-toolchains)
