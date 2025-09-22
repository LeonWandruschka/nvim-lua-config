-- Map ',' to <Leader>
vim.g.mapleader = " "

-- Map <C-j> to <Down> in Insert mode
vim.keymap.set('i', '<C-j>', '<Down>', {silent = true, noremap = true})

-- Map <C-k> to <Up> in Insert mode
vim.keymap.set('i', '<C-k>', '<Up>', {silent = true, noremap = true})

-- Map <C-h> to <Left> in Insert mode
vim.keymap.set('i', '<C-h>', '<Left>', {silent = true, noremap = true})

-- Map <C-l> to <Right> in Insert mode
vim.keymap.set('i', '<C-l>', '<Right>', {silent = true, noremap = true})

-- Map <C-f> to <Right> in Insert mode (same as <C-l>)
vim.keymap.set('i', '<C-f>', '<Right>', {silent = true, noremap = true})

-- Map <C-d> to <Del> in Insert mode
vim.keymap.set('i', '<C-d>', '<Del>', {silent = true, noremap = true})

-- Map :tabnext<CR> to <TAB> in Normal mode
vim.keymap.set('n', '<TAB>', ':tabnext<CR>', {silent = true, noremap = true})

-- Map :tabprevious<CR> to <TAB> in Normal mode
vim.keymap.set('n', '<S-TAB>', ':tabprevious<CR>', {silent = true, noremap = true})

