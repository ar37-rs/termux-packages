TERMUX_PKG_HOMEPAGE=https://github.com/lxqt/lxqt-wayland-session
TERMUX_PKG_DESCRIPTION="Files needed for the LXQt Wayland Session"
TERMUX_PKG_LICENSE="BSD 3-Clause, GPL-2.0, GPL-3.0, LGPL-2.1, MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="0.2.0"
TERMUX_PKG_SRCURL=https://github.com/lxqt/lxqt-wayland-session/releases/download/${TERMUX_PKG_VERSION}/lxqt-wayland-session-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d7a88964fe705bcf40a6d04eb1d570c01a01d6dc5104dd393dc4effcb5a9cd28
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_DEPENDS="layer-shell-qt, lxqt-session, qtxdg-tools"
TERMUX_PKG_BUILD_DEPENDS="lxqt-build-tools, qt6-qttools"
TERMUX_PKG_SUGGESTS="labwc, sway"
