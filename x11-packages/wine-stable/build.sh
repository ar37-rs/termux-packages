TERMUX_PKG_HOMEPAGE=https://www.winehq.org/
TERMUX_PKG_DESCRIPTION="A compatibility layer for running Windows programs"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_LICENSE_FILE="LICENSE, LICENSE.OLD, COPYING.LIB"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="10.4"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://dl.winehq.org/wine/source/${TERMUX_PKG_VERSION%%.*}.x/wine-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=a09019ce5c42ba06ba91ec423d49d8f2a9a8eac4c1a9230c73e1d119639d5e92
TERMUX_PKG_DEPENDS="fontconfig, freetype, krb5, libandroid-spawn, libc++, libgmp, libgnutls, libxcb, libxcomposite, libxcursor, libxfixes, libxrender, mesa, opengl, pulseaudio, sdl2 | sdl2-compat, vulkan-loader, xorg-xrandr"
TERMUX_PKG_ANTI_BUILD_DEPENDS="sdl2-compat, vulkan-loader"
TERMUX_PKG_BUILD_DEPENDS="libandroid-spawn-static, vulkan-loader-generic"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="
--without-x
--disable-tests
"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
enable_wineandroid_drv=yes
enable_tools=yes
--prefix=$TERMUX_PREFIX/opt/wine-stable
--exec-prefix=$TERMUX_PREFIX/opt/wine-stable
--libdir=$TERMUX_PREFIX/opt/wine-stable/lib
--with-wine-tools=$TERMUX_PKG_HOSTBUILD_DIR
--enable-nls
--disable-tests
--without-alsa
--without-capi
--without-coreaudio
--without-cups
--with-fontconfig
--with-freetype
--without-gettext
--with-gettextpo=no
--without-gphoto
--with-gnutls
--with-gstreamer
--with-krb5
--with-mingw
--without-opencl
--without-osmesa
--without-oss
--without-pcap
--without-pthread
--with-pulse
--without-sane
--without-oss
--without-udev
--without-unwind
--without-usb
--without-v4l2
--without-xinerama
"

# Enable win64 on 64-bit arches.
if [ "$TERMUX_ARCH_BITS" = 64 ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-win64"
fi

# Enable new WoW64 support on x86_64.
if [ "$TERMUX_ARCH" = "x86_64" ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-archs=i386,x86_64"
fi

TERMUX_PKG_BLACKLISTED_ARCHES="arm"

_setup_llvm_mingw_toolchain() {
	# LLVM-mingw's version number must not be the same as the NDK's.
	local _llvm_mingw_version=21
	local _version="20250319"
	local _url="https://github.com/mstorsjo/llvm-mingw/releases/download/$_version/llvm-mingw-$_version-ucrt-ubuntu-20.04-x86_64.tar.xz"
	local _path="$TERMUX_PKG_CACHEDIR/$(basename $_url)"
	local _sha256sum=ab2a1489416fa82b3e85e88cb877053ee8a591993408caf076737d8de5ae72ca
	termux_download $_url $_path $_sha256sum
	local _extract_path="$TERMUX_PKG_CACHEDIR/llvm-mingw-toolchain-$_llvm_mingw_version"
	if [ ! -d "$_extract_path" ]; then
		mkdir -p "$_extract_path"-tmp
		tar -C "$_extract_path"-tmp --strip-component=1 -xf "$_path"
		mv "$_extract_path"-tmp "$_extract_path"
	fi
	export PATH="$PATH:$_extract_path/bin"
}

termux_step_host_build() {
	# Setup llvm-mingw toolchain
	_setup_llvm_mingw_toolchain

	# Make host wine-tools
	"$TERMUX_PKG_SRCDIR/configure" ${TERMUX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$TERMUX_PKG_MAKE_PROCESSES" __tooldeps__ nls/all
}

termux_step_pre_configure() {
	# Setup llvm-mingw toolchain
	_setup_llvm_mingw_toolchain

	# Fix overoptimization
	CPPFLAGS="${CPPFLAGS/-Oz/}"
	CFLAGS="${CFLAGS/-Oz/}"
	CXXFLAGS="${CXXFLAGS/-Oz/}"

	# Disable hardening
	CPPFLAGS="${CPPFLAGS/-fstack-protector-strong/}"
	CFLAGS="${CFLAGS/-fstack-protector-strong/}"
	CXXFLAGS="${CXXFLAGS/-fstack-protector-strong/}"
	LDFLAGS="${LDFLAGS/-Wl,-z,relro,-z,now/}"

	LDFLAGS+=" -landroid-spawn"

	if [ "$TERMUX_ARCH" = "x86_64" ]; then
		mkdir -p "$TERMUX_PKG_TMPDIR/bin"
		cat <<- EOF > "$TERMUX_PKG_TMPDIR/bin/x86_64-linux-android-clang"
			#!/bin/bash
			set -- "\${@/-mabi=ms/}"
			exec $TERMUX_STANDALONE_TOOLCHAIN/bin/x86_64-linux-android-clang "\$@"
		EOF
		chmod +x "$TERMUX_PKG_TMPDIR/bin/x86_64-linux-android-clang"
		export PATH="$TERMUX_PKG_TMPDIR/bin:$PATH"
	fi
}

termux_step_make_install() {
	make -j $TERMUX_PKG_MAKE_PROCESSES install

	# Create wine-stable script
	mkdir -p $TERMUX_PREFIX/bin
	cat << EOF > $TERMUX_PREFIX/bin/wine-stable
#!$TERMUX_PREFIX/bin/env sh

exec $TERMUX_PREFIX/opt/wine-stable/bin/wine "\$@"

EOF
	chmod +x $TERMUX_PREFIX/bin/wine-stable
}
