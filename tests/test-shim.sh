#!/bin/sh

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd 'set loadplugins' --cmd "lua package.path = package.path .. ';$(pwd)/tests/?.lua'" -l $@

exit $?
