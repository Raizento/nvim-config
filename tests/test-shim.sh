#!/bin/sh

if [ -z $XDG_CONFIG_HOME ]; then
  NVIM_DIR="nvim"
else
  NVIM_DIR="nvim-config"
fi

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd 'set loadplugins' --cmd 'lua vim.g.istest = true' --cmd "lua package.path = package.path .. ';${XDG_CONFIG_HOME}/${NVIM_DIR}/tests/?.lua'" -l $@
exit_code=$?

exit $exit_code
