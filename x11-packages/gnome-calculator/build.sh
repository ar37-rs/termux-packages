TERMUX_PKG_HOMEPAGE=https://apps.gnome.org/Calculator
TERMUX_PKG_DESCRIPTION="GNOME Scientific calculator"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="48.0.2"
TERMUX_PKG_SRCURL=https://download.gnome.org/sources/gnome-calculator/${TERMUX_PKG_VERSION%%.*}/gnome-calculator-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=a4cdbab35be24bb4017359b99ffcb6c8afc00848291ad7a4720e6ca075700dc4
TERMUX_PKG_DISABLE_GIR=false
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="glib, gtk4, gtksourceview5, libadwaita, libgee, libmpc, libmpfr, libsoup3, libxml2"
TERMUX_PKG_BUILD_DEPENDS="g-ir-scanner, glib-cross, valac"
TERMUX_PKG_RECOMMENDS="gnome-calculator-help"

termux_step_pre_configure() {
	termux_setup_gir
	termux_setup_glib_cross_pkg_config_wrapper
}
