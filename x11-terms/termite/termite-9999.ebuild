# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils

DESCRIPTION="A keyboard-centric VTE-based terminal"
EGIT_REPO_URI="https://github.com/thestinger/termite"
HOMEPAGE="https://github.com/thestinger/termite"
SLOT="0"

LICENSE="MIT"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/vte
"

PATCHES=(
	"${FILESDIR}/${P}_remap-font-size-change.patch"
)

src_prepare() {
	default
	sed -i /-s /d Makefile
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
