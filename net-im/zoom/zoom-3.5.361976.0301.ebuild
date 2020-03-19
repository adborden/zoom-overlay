# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Zoom.us video conferencing client."
HOMEPAGE="https://zoom.us"
SRC_URI="https://d11yldzmag5yn.cloudfront.net/prod/${PV}/zoom_x86_64.tar.xz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${PN}

src_install() {
	dodir /opt/${PN}
	cp -R "${S}/" "${D}/opt/"
	dosym ../../opt/zoom/ZoomLauncher /usr/bin/zoom
}
