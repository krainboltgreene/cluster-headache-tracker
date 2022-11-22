#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive &&
	apt-get install --no-install-recommends -y libncurses5 libwxgtk3.0-gtk3-dev libsctp1 libssh-dev xsltproc fop libxml2-utils &&
	curl -fSL -o /tmp/erlang.deb https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_25.0.4-1~ubuntu~focal_amd64.deb &&
	dpkg -i /tmp/erlang.deb &&
	rm /tmp/erlang.deb
