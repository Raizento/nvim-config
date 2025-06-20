#!/bin/sh

export XDG_DATA_HOME="$(mktemp -d)"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd "lua package.path = package.path .. ';$(pwd)/tests/?.lua'" -l $@

rm -rf $XDG_DATA_HOME

exit $?
