return {
  "danymat/neogen",
  cmd = "Neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    languages = {
      c = { template = { annotation_convention = "doxygen" } },
      cpp = { template = { annotation_convention = "doxygen" } },
    },
  },
}
