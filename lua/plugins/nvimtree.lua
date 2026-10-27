return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    view = {
      float = {
        enable = true,
        open_win_config = {
          border = "rounded"
        }
      }
    },
  },
}
