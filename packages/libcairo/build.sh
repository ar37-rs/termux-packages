TERMUX_PKG_HOMEPAGE=https://cairographics.org
TERMUX_PKG_DESCRIPTION="Cairo 2D vector graphics library"
TERMUX_PKG_LICENSE="LGPL-2.1"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.18.4"
TERMUX_PKG_SRCURL=https://gitlab.freedesktop.org/cairo/cairo/-/archive/${TERMUX_PKG_VERSION}/cairo-${TERMUX_PKG_VERSION}.tar.bz2
TERMUX_PKG_SHA256=6d9281e786fd289d382324d4588d59973a36911e1865b40e64f9ec39936ceba8
TERMUX_PKG_DEPENDS="fontconfig, freetype, glib, libandroid-shmem, libandroid-execinfo, liblzo, libpixman, libpng, libx11, libxcb, libxext, libxrender, zlib"
TERMUX_PKG_BREAKS="libcairo-dev, libcairo-gobject"
TERMUX_PKG_REPLACES="libcairo-dev, libcairo-gobject"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-Dpng=enabled
-Dzlib=enabled
-Dglib=enabled
-Dgtk_doc=false
"

termux_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem -landroid-execinfo"
}
