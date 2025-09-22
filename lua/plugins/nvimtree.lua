return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false,      -- Show dotfiles
        git_ignored = false,   -- Show .gitignored files
      },
      view = {
        -- Set the name of the NvimTree window to "NvimTree"
        float = {
          enable = true,
          open_win_config = {
            border = "rounded",  -- Optional, for aesthetics
          },
        },
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    })

    -- Remove the "Lua" label from the window (optional)
    vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none' })
    vim.opt.winbar = nil  -- Remove the winbar if using it

    -- Key mappings
    vim.keymap.set({ "n", "i", "v" }, "<c-b>", "<ESC>:NvimTreeToggle<CR>", { noremap = true, silent = true })

    -- Keymap for ESC to toggle NvimTree if it's open
    vim.keymap.set("n", "<Esc>", function()
      local nvim_tree_view = require("nvim-tree.view")
      if nvim_tree_view.is_visible() then
        vim.cmd("NvimTreeToggle")
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      end
    end, { noremap = true, silent = true })
  end,
}

