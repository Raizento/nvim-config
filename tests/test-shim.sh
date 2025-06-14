#!/bin/sh

nvim --cmd 'set loadplugins' --cmd 'lua vim.g.istest = true' -u ~/.config/nvim/init.lua -l $@
exit_code=$?

exit $exit_code
