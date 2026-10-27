local languages = {
  "vim",
  "vimdoc",
  "lua",
  "c",
  "cpp",
  "python",
  "systemverilog",
  "markdown",
  "typst",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").install(languages)
  end,
}
