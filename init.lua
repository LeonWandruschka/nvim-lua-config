-- NeoVim Setup by Leon Wandruschka

-- Setup Lazy Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

require("core/options")
require("core/keymaps")
require("core/commands")
require("lazy").setup("plugins")

-- Load the saved colorscheme and lualine theme if it exists
local colorscheme_file = vim.fn.stdpath('config') .. '/lua/core/colorscheme.lua'
if vim.fn.filereadable(colorscheme_file) == 1 then
    dofile(colorscheme_file)
end

-- Function to set both colorscheme and Lualine theme
local function set_theme(theme)
    -- Set the colorscheme
    vim.cmd('colorscheme ' .. theme)

    -- Set the lualine theme to match
    require('lualine').setup {
        options = {
            theme = theme  -- change the theme to match the colorscheme
        }
    }

    -- Save the current colorscheme and lualine theme
    local file = io.open(colorscheme_file, 'w')
    if file then
        file:write('vim.cmd("colorscheme ' .. theme .. '")\n')
        file:write('require("lualine").setup { options = { theme = "' .. theme .. '" } }\n')
        file:close()
    end
end

-- Set up an autocommand to save the colorscheme and lualine theme when changed
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
        local current_colorscheme = vim.api.nvim_exec('colorscheme', true)
        set_theme(current_colorscheme)
    end,
})

