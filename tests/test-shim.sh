#!/bin/sh

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd 'set loadplugins' --cmd 'lua vim.g.istest = true' -u $XDG_CONFIG_HOME/nvim/init.lua -l $@
exit_code=$?

exit $exit_code
