TERMUX_PKG_HOMEPAGE=https://github.com/BLAKE3-team/BLAKE3/tree/master/b3sum
TERMUX_PKG_DESCRIPTION="A command line utility for calculating BLAKE3 hashes, similar to Coreutils tools like b2sum or md5sum"
TERMUX_PKG_LICENSE="CC0-1.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.6.1"
TERMUX_PKG_SRCURL=https://github.com/BLAKE3-team/BLAKE3/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=1f2fbd93790694f1ad66eef26e23c42260a1916927184d78d8395ff1a512d285
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	termux_setup_rust

	cd $TERMUX_PKG_SRCDIR/b3sum

	cargo build --jobs $TERMUX_PKG_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm755 -t $TERMUX_PREFIX/bin $TERMUX_PKG_SRCDIR/b3sum/target/${CARGO_TARGET_NAME}/release/b3sum
}
