local M = {
    "mfussenegger/nvim-dap",
}

M.config = function()
    local path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    local dap = require("dap")
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = path,
            args = { "--port", "${port}", }
        }
    }

    local function debug()
        local exists = require("raizento.util.exists")
        local os = require("os")

        local bin_path = vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

        if not exists.exists(bin_path) then
            os.execute("cargo build")
        end

        return bin_path
    end

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = debug,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
end

return M
