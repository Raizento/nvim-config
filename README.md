# ReadMe

## Requirements
For inlay hints to work, you need at least version 0.10.0.

To be able to fully use all features of this config, install the following dependencies:

`sudo apt install gcc g++ ripgrep fd-find`

Lazygit:

```
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

## Keymaps
All keymaps have entries in `which-key`. 

## Adding a new LSP
Installing a new LSP is done via the `:LspInstall {servername}` command. 

You may need to run `:LspStart` for cmp to properly use the LSP sources. 

A new LSP will be configured using a default config. However, you can also configure an LSP on your own.

### Configuring an LSP
If you want to do additional LSP configuring, head to the `lua/raizento/lsp/config` directory. 
Take a look at `lua_ls.lua`:
```lua
local M = {}

M.config = function(capabilities, on_attach)
  return function()
    require("lspconfig").lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          hint = {
            enable = true,
            paramName = "All",
          },
        },
      },
    })
  end
end

return M
```

You need to add a file `lua/raizento/lsp/config/servername.lua` 

For the config to recognize the file it has to have the exact same name that `lspconfig` uses (so `{lspconfig_servername}.lua`).

Your `servername.lua` file needs a table which has a `config` entry. The `config` entry needs to return a function covering all your configuration steps.
**This includes the call to `lspconfig` to setup the server.**

### Already set up LSPs
`nvim-java` sets up `JDTLS` and `spring-boot-tools` for Java.
