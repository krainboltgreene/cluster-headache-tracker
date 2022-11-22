#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive &&
	apt-get install --no-install-recommends -y inotify-tools &&
	curl -fSL -o /tmp/elixir-otp-25.zip https://github.com/elixir-lang/elixir/releases/download/v1.14.1/elixir-otp-25.zip &&
	unzip /tmp/elixir-otp-25.zip -d /usr/bin/elixir &&
	rm /tmp/elixir-otp-25.zip
