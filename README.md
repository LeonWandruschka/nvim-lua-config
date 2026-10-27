# Neovim Configuration in Lua

Welcome to my **Neovim Configuration**!

## 🚀 Installation

### 📌 Prerequisites

Ensure you have the following dependencies installed:

- **Neovim** (Version 0.11 or higher)
- **Exuberant Ctags** (For tag generation)
- **JetBrains Nerd Font or similar mono font** ([Download here](https://www.nerdfonts.com/font-downloads))
- **ripgrep** (For Telescope text search)
- **LazyGit** (For Git integration)
- **clangd** (Installed locally for architecture-independent C/C++ LSP support)
- **tree-sitter CLI** (For compiling Treesitter parsers)
- **StyLua** and **clang-format** (For formatting through none-ls)

Mason installs `lua_ls`, `marksman`, `tinymist`, and the C/C++ debug adapter. `clangd` is deliberately installed through the system package manager instead of Mason to avoid ARM/x86 binary conflicts.

Install dependencies using your package manager. For example, on Ubuntu:

```bash
sudo apt update
sudo apt install git curl unzip tar build-essential ripgrep universal-ctags clangd clang-format nodejs npm cargo tree-sitter-cli
```

On macOS, you can use Homebrew:

```bash
xcode-select --install
brew install neovim git ripgrep lazygit universal-ctags stylua llvm tree-sitter-cli nodejs npm
```

Optionally install the configured icon font:
```bash
brew install --cask font-jetbrains-mono-nerd-font
```

### ⚙️ Configuration

Clone this repository into your Neovim configuration directory:

```bash
git clone https://github.com/LeonWandruschka/nvim-lua-config.git ~/.config/nvim
```

## 🌟 Featured Plugins

This configuration includes powerful plugins to enhance productivity:

- 📌 `alpha-nvim` - Customizable dashboard
- 🎨 `colorscheme` - Custom themes for a personalized look
- 🔍 `telescope.nvim` - Fuzzy file searching and previewing
- 📝 `treesitter` - Improved syntax highlighting
- 🔧 `nvim-lspconfig` - Language Server Protocol setup
- ✨ `nvim-cmp` - LSP completion and snippets
- 🛠️ `none-ls.nvim` - StyLua and clang-format integration
- 📂 `nvim-tree` - File explorer
- 🛑 `dap.nvim` - Debug Adapter Protocol for debugging
- 📝 `neogen` - Generate Doxygen-style comments
- 🏷️ `tagbar` - Displays tags in a sidebar
- ✅ `todo-comments` - Highlights TODO/FIXME comments
- 🔗 `lazygit` - Git integration
- 📄 `typst-preview.nvim` - Live Typst preview using Tinymist

## 🎮 Keybindings

Enhance your workflow with these shortcuts:

### General Keybindings

| Action | Keybinding |
|--------|-----------|
| **Leader Key** | `<Space>` |
| **Hover for Function Info** | `I` |
| **Go to Definition** | `<leader>gd` |
| **Code Action** | `<leader>ca` |
| **Format Code** | `<leader>cf` |
| **Toggle File Explorer** | `<C-n>` |
| **Focus File Explorer** | `<leader>e` |
| **Search Files** | `<leader>ff` |
| **Search All Files** | `<leader>fa` |
| **Search Text (Ripgrep)** | `<leader>g` |
| **Generate Documentation** | `<leader>nd` |

### Debugging Keybindings

| Action | Keybinding |
|--------|-----------|
| **Run Build Task** | `<leader>bb` |
| **Toggle Breakpoint** | `<leader>db` |
| **Conditional Breakpoint** | `<leader>dB` |
| **Start Debugging** | `<leader>dc` |
| **Step Over** | `<leader>do` |
| **Step Into** | `<leader>di` |
| **Step Out** | `<leader>du` |
| **Pause Debugging** | `<leader>dp` |
| **Terminate Debugging** | `<leader>dt` |
| **Open DAP REPL** | `<leader>dr` |
| **Run Last Session** | `<leader>dl` |
| **Toggle DAP UI** | `<leader>dut` |

### Git Keybindings

| Action | Keybinding |
|--------|-----------|
| **Open LazyGit** | `<leader>lg` |

### Completion Keybindings

| Action | Keybinding |
|--------|-----------|
| **Open Completion** | `<C-Space>` |
| **Close Completion** | `<C-e>` |
| **Confirm Completion** | `<CR>` |
| **Next Item / Snippet Field** | `<Tab>` |
| **Previous Item / Snippet Field** | `<S-Tab>` |

## 📁 Directory Structure

Understand the file tree for easy customization:

```zsh
.
├── Dockerfile
├── README.md
├── init.lua
└── lua
    ├── core
    │   ├── colorscheme.lua
    │   ├── keymaps.lua
    │   └── options.lua
    └── plugins
        ├── alpha-nvim.lua
        ├── autopairs.lua
        ├── colorscheme.lua
        ├── completion.lua
        ├── debugging.lua
        ├── diagnostics.lua
        ├── lazygit.lua
        ├── lsp-config.lua
        ├── lualine.lua
        ├── neogen.lua
        ├── none-ls.lua
        ├── nvimtree.lua
        ├── tagbar.lua
        ├── telescope.lua
        ├── todo_comments.lua
        ├── treesitter.lua
        └── typst-preview.lua
```

## 🐳 Running in Docker

You can try this configuration inside a **Docker container**:

```zsh
docker build -t neovim-config .
```

Run the container:

```zsh
docker run --rm -it neovim-config
```

To remove the image afterward:

```zsh
docker rmi neovim-config
```
