-- install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local output = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Could not install lazy.nvim:\n" .. output)
  end
end

-- make lazy.nvim available in runtime path
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")
require("lazy").setup("plugins", { change_detection = { notify = false } })
require("core.colorscheme")
