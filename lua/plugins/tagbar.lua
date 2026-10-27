return {
  "preservim/tagbar",
  cmd = { "TagbarOpen", "TagbarClose" },
  init = function()
    vim.g.tagbar_autofocus = 1
  end,
}
