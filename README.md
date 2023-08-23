# ReadMe

## Requirements
To be able to fully use all of this configs features, a few requirements need to be installed:

`sudo apt install gcc g++ ripgrep fd-find`

Lazygit:

```
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

## Keymaps
This config uses [which-key](https://github.com/folke/which-key.nvim). As such, all keybindings can be found out by simply messing around. Have fun!

## Adding a new LSP
Installing a new LSP is done via the `:LspInstall {servername}` command. 

You may need to run `:LspStart` for the LSP to start after installing in a buffer which had no LSP attached.

A new LSP will be configured using a default config. However, you can also configure an LSP on your own.

### Configuring an LSP
If you want to do additional LSP configuring, head to the `lua/raizento/lsp/config` directory. 
Take a look at `rust_analyzer.lua`:
```lua
local M = {}

M.config = function(lsp_config, capabilities)
  return function()
    require("rust-tools").setup{}
  end
end

return M
```

You need to add a file `lua/raizento/lsp/config/servername.lua` 

For the config to recognize the file, it has to have the exact same name as `lspconfig` uses (so `{lspconfig_servername}.lua`).

Inside your file, you need to create a table which has a `config`-entry. It, in turn, needs to return a function covering all your configuration steps.
