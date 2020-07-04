# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools vala

DESCRIPTION="An enhanced terminal emulator widget"
HOMEPAGE="https://github.com/thestinger/vte-ng"
LICENSE="LGPL-2.1"
SLOT="0"
EGIT_REPO_URI="https://github.com/thestinger/vte-ng"

KEYWORDS="~amd64 ~x86"

IUSE="+introspection +crypt vala"

RDEPEND="
	>=dev-libs/glib-2.40:2
	>=dev-libs/libpcre2-10.21
	>=x11-libs/gtk+-3.16:3[introspection?]
	>=x11-libs/pango-1.22.0

	sys-libs/ncurses:0=
	sys-libs/zlib

	crypt? ( >=net-libs/gnutls-3.2.7:0= )
	introspection? ( >=dev-libs/gobject-introspection-0.9.0:= )
"

DEPEND="${RDEPEND}
	dev-util/gperf
	dev-libs/libxml2
	>=dev-util/gtk-doc-am-1.13
	>=dev-util/intltool-0.35
	sys-devel/gettext

	dev-util/gtk-doc

	!x11-libs/vte

	vala? ( $(vala_depend) )
"

src_prepare() {
	default

	use vala && vala_src_prepare

	eautoreconf
}

src_configure() {
	econf $(use_enable vala)\
		  $(use_with crypt gnutls)\
		  $(use_enable introspection)\

}
