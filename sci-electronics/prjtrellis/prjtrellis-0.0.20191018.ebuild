EAPI=6

inherit cmake-utils

GIT_COMMIT=72fe507c2b445500d48e94e5bf6a9a636392823e
DB_GIT_COMMIT=5b5bb70bae13e6b8c971b4b2d26931f4a64b51bc
S=$WORKDIR/$PN-$GIT_COMMIT/libtrellis

DESCRIPTION="reverse-engineered tools for Lattice ECP5 FPGAs"
HOMEPAGE="https://prjtrellis.readthedocs.io"
SRC_URI="https://github.com/SymbiFlow/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz
	 https://github.com/SymbiFlow/$PN-db/archive/$DB_GIT_COMMIT.tar.gz -> $PN-db-$PV.tar.gz"
LICENSE=ISC
SLOT=0
KEYWORDS=~amd64

DEPEND="dev-vcs/git
	dev-libs/boost
	dev-embedded/openocd"

src_unpack() {
	unpack $P.tar.gz
	cd $WORKDIR/$PN-$GIT_COMMIT
	unpack $PN-db-$PV.tar.gz
	rmdir database
	mv $PN-db-$DB_GIT_COMMIT database
}

# see https://github.com/SymbiFlow/prjtrellis/pull/95
src_configure() {
	local mycmakeargs=(
		-DCURRENT_GIT_VERSION=$GIT_COMMIT
	)
	cmake-utils_src_configure
}
