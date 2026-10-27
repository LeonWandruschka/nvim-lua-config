vim.g.mapleader = " "

local map = vim.keymap.set

-- Insert mode mappings
map("i", "<C-b>", "<Esc>^i", { desc = "Start of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })

-- Window navigation mappings
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- File search mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", { desc = "Find all files" })
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { desc = "Find text" })

-- Comment mappings
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment" })
map("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })

-- File tree mappings
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file tree" })

-- Code navigation and actions
map("n", "I", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format file" })

-- The only Git mapping.
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Doxygen like comments
map("n", "<leader>nd", "<cmd>Neogen<cr>", { desc = "Generate documentation" })

-- Tagbar mappings
map({ "n", "i" }, "<leader>tb", "<Esc><cmd>TagbarOpen<cr>", { desc = "Open Tagbar" })
map({ "n", "i" }, "<leader>tc", "<Esc><cmd>TagbarClose<cr>", { desc = "Close Tagbar" })

