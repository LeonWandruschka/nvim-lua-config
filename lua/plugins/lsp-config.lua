local servers = {
  "lua_ls",
  "clangd",
  "marksman",
  "tinymist",
}

return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs(servers) do
        local config = { capabilities = capabilities }
        -- Currently there is no arm version of clangd in mason,
        -- so we are using the system clangd instead of the mason one.
        if server == "clangd" then
          config.mason = false
          config.cmd = { "clangd", "--background-index", "--clang-tidy" }
        end

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
}
