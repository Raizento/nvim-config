#!/bin/sh

export XDG_DATA_HOME="$(mktemp -d)"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd "lua package.path = package.path .. ';$(pwd)/tests/?.lua'" -l $@

# sleep so that all files used by nvim are free again
sleep 1
rm -rf $XDG_DATA_HOME

exit $?
