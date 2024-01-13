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
Coming soon.
In the meantime, you can use `which-key`

## Adding a new LSP
Installing a new LSP is done via the `:LspInstall {servername}` command. 

You may need to run `:LspStart` for cmp to properly use the LSP sources. 

A new LSP will be configured using a default config. However, you can also configure an LSP on your own.

### Configuring an LSP
If you want to do additional LSP configuring, head to the `lua/raizento/lsp/config` directory. 
Take a look at `rust_analyzer.lua`:
```lua
local M = {}

M.config = function(capabilities)
  return function()
    require("rust-tools").setup({})
  end
end

return M
```

You need to add a file `lua/raizento/lsp/config/servername.lua` 

For the config to recognize the file it has to have the exact same name as `lspconfig` uses (so `{lspconfig_servername}.lua`).

Inside your file, you need to create a table which has a `config`-entry. It needs to return a function covering all your configuration steps.
**This includes the call to `lspconfig` to setup the server.**

### Using plugins for LSP configuration

Plugins for LSP configuration such as `neodev` or `rust-tools` can be put into `lua/raizento/lsp/lsp-plugins.lua`.
The corresponding servers should then be setup in the way described above.

