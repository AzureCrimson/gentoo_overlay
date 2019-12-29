EAPI=6

inherit cmake-utils

GIT_COMMIT=b582ba810cc54282d4c574bee80a7339c8da17f9
S=$WORKDIR/$PN-$GIT_COMMIT

DESCRIPTION="portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"
SRC_URI="https://github.com/YosysHQ/$PN/archive/$GIT_COMMIT.tar.gz -> $P.tar.gz"
LICENSE=ISC
SLOT=0
KEYWORDS=~amd64
IUSE="ice40 ecp5"

DEPEND="ice40? ( sci-electronics/icestorm
	         >=dev-embedded/yosys-0.8 )
	ecp5? ( sci-electronics/prjtrellis
	        >dev-embedded/yosys-0.8 )
	dev-qt/qtcore:5
	dev-libs/boost"

src_configure() {
	local mycmakeargs=(
		$(usex ice40 $(usex ecp5 "-DARCH=all" "-DARCH=ice40") $(usex ecp5 "-DARCH=ecp5" "-DARCH=generic"))
		$(usex ice40 -DICEBOX_ROOT=/usr/share/icebox "")
		$(usex ecp5 -DTRELLIS_ROOT=/usr/share/trellis "")
	)
	cmake-utils_src_configure
}

