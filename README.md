# mini-ndk

Provide zig with the ability to compile for android targeted binary.

## The story

Compiling android targeted biarny is a pain on aarch64 linux and android, because ndk is not distributed on them, finally i found a repo is able to compile android targetd binary.  

The [llvm-cross-toolchains](https://github.com/shengyun-zhou/llvm-cross-toolchains).

I then learned that we can assemable a complete toolchain by placing llvm resource dir to the right and passing the sysroot argument to toolchain. this link [Assembling a Complete Toolchain](https://clang.llvm.org/docs/Toolchain.html) will give more details.

By comparing the verbose log bettween the working toolchain and my cripple one, i finnally figured it out how to make it work, and i wrote this automatic script.

Why do i choose zig rather than origional llvm toolchain?

* zig can run on raw android (not prooted, not chrooted).
* zig updates and release toolchain frequently.
* zig can build for many many targets already.
* zig release package is much smaller than llvm relase package.

I create this script to make zig to be able to compile android targeted binary on raw android.

## Setup instruction

Download these required resources:

* [zig-ndk](https://github.com/zongou/zig-ndk) (this script)
* [zig](https://ziglang.org/download/)
* ndk from [google site](https://developer.android.google.com/ndk/downloads) or [github release](https://github.com/android/ndk/releases)

Then run:

```sh
## unzip android ndk
unzip <android_ndk_package>
## setup
./zig-ndk setup <ndk_home>
```

## Relavent links

* [llvm-project](https://github.com/llvm/llvm-project)
* [llvmbox](https://github.com/rsms/llvmbox)
* [llvm-cross-toolchains](https://github.com/shengyun-zhou/llvm-cross-toolchains)
