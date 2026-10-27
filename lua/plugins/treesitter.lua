local languages = {
  -- config
  "vim",
  "vimdoc",
  "lua",

  -- programming
  "c",
  "cpp",
  "python",
  "verilog",

  -- documentation
  "markdown",
  "typst",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = languages,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
