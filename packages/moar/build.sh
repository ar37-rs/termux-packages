TERMUX_PKG_HOMEPAGE=https://github.com/walles/moar
TERMUX_PKG_DESCRIPTION="A pager designed to just do the right thing without any configuration"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.31.7"
TERMUX_PKG_SRCURL=https://github.com/walles/moar/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=02e7f8c7f6163380eb444ae45bf353c644a260bb30b9b60a18fef4b028b847e4
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	termux_setup_golang
	go build -trimpath -ldflags="-s -w -X main.versionString=${TERMUX_PKG_VERSION}"
}

termux_step_make_install() {
	install -Dm700 -t "${TERMUX_PREFIX}/bin" moar
	install -Dm600 -t "${TERMUX_PREFIX}/share/man/man1" moar.1
}
