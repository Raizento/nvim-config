#!/bin/sh

# This is just wrong; need to maybe check a github variable
if [ -z "$CI" ]; then
  NVIM_DIR="nvim"
else
  NVIM_DIR="nvim-config"
fi

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

nvim --cmd 'set loadplugins' --cmd "lua package.path = package.path .. ';$(pwd)/tests/?.lua'" -l $@
exit_code=$?

exit $exit_code
