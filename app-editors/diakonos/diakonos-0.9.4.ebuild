# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

USE_RUBY="ruby23 ruby24 ruby25 ruby26"

inherit ruby-ng

DESCRIPTION="A Linux editor for the masses"
HOMEPAGE="http://diakonos.pist0s.ca"
SRC_URI="http://diakonos.pist0s.ca/archives/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

ruby_add_rdepend "dev-ruby/curses"

ruby_add_bdepend "doc? ( dev-ruby/yard )
	test? ( dev-ruby/bacon )"

each_ruby_install() {
	${RUBY} install.rb --dest-dir "${D}" --doc-dir /usr/share/doc/${P} || die "install failed"
}

all_ruby_install() {
	if use doc; then
		rake docs || die
		dodoc -r doc/*
	fi
}

each_ruby_test() {
	${RUBY} -S bacon -Ilib spec/*.rb spec/*/*.rb || die
}
