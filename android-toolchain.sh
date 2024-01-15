#!/bin/sh
set -eu
SCRIPT_DIR=$(dirname "$(realpath $0)")

# shellcheck disable=SC2059
msg() { printf "$(test -t 0 || cat)$@\n"; }
err_args() { msg "Error: "; }

get_ndk_resource() {
	ANDROID_NDK_HOME="$1"
	NDK_SYSROOT="$(find "${ANDROID_NDK_HOME}" -name sysroot -type d)"
	NDK_CLANG_RESOURCE="$(find "${ANDROID_NDK_HOME}" -path "*/lib/clang/[0-9][0-9]" -type d)"

	rm -rf "${SCRIPT_DIR}/sysroot"
	cp -r "${NDK_SYSROOT}" "${SCRIPT_DIR}/sysroot"
	rm -rrf "${SCRIPT_DIR}/resource"
	cp -r "${NDK_CLANG_RESOURCE}" "${SCRIPT_DIR}/resource"
}

create_target_wrapper() {
	abi_min="$(cat "${ANDROID_NDK_HOME}/meta/platforms.json" | grep "\"min\": " | grep -E -o "[0-9]+")"
	abi_max="$(cat "${ANDROID_NDK_HOME}/meta/platforms.json" | grep "\"max\": " | grep -E -o "[0-9]+")"

	mkdir -p "${SCRIPT_DIR}/bin"
	for n in $(seq "${abi_min}" "${abi_max}"); do
		for abi in "aarch64-linux-android${n}" "armv7a-linux-androideabi${n}" "x86_64-linux-android${n}" "i686-linux-android${n}"; do
			ln -snf ../wrappers/target_wrapper "${SCRIPT_DIR}/bin/${abi}-clang"
			ln -snf ../wrappers/target_wrapper "${SCRIPT_DIR}/bin/${abi}-clang++"
		done
	done
}

create_zig_wrappers() {
	for tool in ar cc c++ dlltool lib ranlib objcopy ld.lld; do
		ln -snf "../wrappers/zig_wrapper" "bin/${tool}"
	done
}

setup() {
	get_ndk_resource "$1"
	create_target_wrapper

	## If 'CLANG' env is set, create wrappers according to clang varient
	if test "${CLANG+1}"; then
		if ${CLANG} --version | grep -q "zig"; then
			create_zig_wrappers
		fi
	fi
}

main() {
	if test $# -gt 0; then
		while test $# -gt 0; do
			case "$1" in
			setup)
				_FUNC="$1"
				shift
				setup "$@"
				break
				;;
			*)
				err_args "$@"
				break
				;;
			esac
		done
	fi
}

main "$@"
