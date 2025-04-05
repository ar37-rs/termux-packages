TERMUX_PKG_HOMEPAGE=https://nextcloud.com/
TERMUX_PKG_DESCRIPTION="Command-line client tool for Nextcloud."
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="3.16.2"
TERMUX_PKG_SRCURL="https://github.com/nextcloud/desktop/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz"
TERMUX_PKG_SHA256=26048f697d2d1db23c2c4f50931bfdefff59db91812f4945a36dd232380719f3
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="dbus, dbus-glib, libp11, qtkeychain, qt6-qtbase, qt6-qttools, inotify-tools, libsqlite, kf6-karchive, qt6-qtwebsockets, qt6-qtsvg, qt6-qt5compat"
TERMUX_PKG_BUILD_DEPENDS="qt6-qtbase-cross-tools, qt6-qttools-cross-tools, pkg-config, qt6-qtbase, qt6-qttools"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_GUI=OFF
-DBUILD_SHELL_INTEGRATION=OFF
-DBUILD_WITH_WEBENGINE=OFF
-DBUILD_UPDATER=OFF
-DTOKEN_AUTH_ONLY=OFF
-DBUILD_TESTING=OFF
"
