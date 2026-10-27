# Neovim Configuration in Lua

Welcome to my **Neovim Configuration**!

## 🌟 Featured Plugins

This configuration includes powerful plugins to enhance productivity:

- 📌 `alpha-nvim` - Customizable dashboard
- 🎨 `colorscheme` - Custom themes for a personalized look
- 🔍 `telescope.nvim` - Fuzzy file searching and previewing
- 📝 `treesitter` - Improved syntax highlighting
- 🔧 `nvim-lspconfig` - Language Server Protocol setup
- ✨ `nvim-cmp` - LSP completion and snippets
- 🛠️ `none-ls.nvim` - clang-format integration
- 📂 `nvim-tree` - File explorer
- 🛑 `dap.nvim` - Debug Adapter Protocol for debugging
- 📝 `neogen` - Generate Doxygen-style comments
- 🏷️ `tagbar` - Displays tags in a sidebar
- ✅ `todo-comments` - Highlights TODO/FIXME comments
- 🔗 `lazygit` - Git integration
- 📄 `typst-preview.nvim` - Live Typst preview using Tinymist

## 🚀 Installation

### 📌 Prerequisites

Ensure you have the following dependencies installed:

- **Neovim** (Version 0.12.0+)
- **Universal Ctags** (For tag generation)
- **JetBrains Nerd Font or similar mono font** ([Download here](https://www.nerdfonts.com/font-downloads))
- **ripgrep** (For Telescope text search)
- **LazyGit** (For Git integration)
- **clangd** (Installed locally for architecture-independent C/C++ LSP support)
- **tree-sitter CLI** 0.26.1+ (For compiling Treesitter parsers)
- **clang-format** (For C/C++ formatting through none-ls)

Mason installs `lua_ls`, `marksman`, `tinymist`, and the C/C++ debug adapter. `clangd` is deliberately installed through the system package manager instead of Mason to avoid ARM/x86 binary conflicts.

#### macOS

Install the command-line tools and dependencies with Homebrew:

```bash
xcode-select --install
brew install \
  neovim git ripgrep lazygit universal-ctags \
  clang-format tree-sitter-cli
```

Optionally install the configured icon font:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

#### Ubuntu

First install the packages available through APT:

```bash
sudo apt update
sudo apt install -y \
  git curl unzip tar build-essential \
  ripgrep universal-ctags clangd clang-format
```

Ubuntu's Neovim package may be older than the required version. Install the
current stable release from the official Neovim binaries:

```bash
case "$(uname -m)" in
  x86_64) NVIM_ARCH="x86_64" ;;
  aarch64|arm64) NVIM_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

curl -fL \
  "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" \
  -o /tmp/nvim.tar.gz
sudo tar -C /opt -xzf /tmp/nvim.tar.gz
sudo ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim
```

Install Tree-sitter CLI 0.27.1. The commands select the correct binary on
x86-64 and ARM64:

```bash
mkdir -p ~/.local/bin

case "$(uname -m)" in
  x86_64)
    TREE_SITTER_ARCH="x64"
    ;;
  aarch64|arm64)
    TREE_SITTER_ARCH="arm64"
    ;;
  *) echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

curl -fL \
  "https://github.com/tree-sitter/tree-sitter/releases/download/v0.27.1/tree-sitter-cli-linux-${TREE_SITTER_ARCH}.zip" \
  -o /tmp/tree-sitter.zip
unzip -o /tmp/tree-sitter.zip -d ~/.local/bin

chmod +x ~/.local/bin/tree-sitter
export PATH="$HOME/.local/bin:$PATH"
```

Install the current LazyGit release:

```bash
case "$(uname -m)" in
  x86_64) LAZYGIT_ARCH="x86_64" ;;
  aarch64|arm64) LAZYGIT_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
esac

LAZYGIT_VERSION="$(curl -fsSL https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
  | sed -n 's/.*"tag_name": "v\([^"]*\)".*/\1/p' \
  | head -n 1)"

curl -fL \
  "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_${LAZYGIT_ARCH}.tar.gz" \
  -o /tmp/lazygit.tar.gz
tar -C ~/.local/bin -xzf /tmp/lazygit.tar.gz lazygit
chmod +x ~/.local/bin/lazygit
```

### ⚙️ Configuration

Clone this repository into your Neovim configuration directory:

```bash
git clone https://github.com/LeonWandruschka/nvim-lua-config.git ~/.config/nvim
```

#### Ubuntu

Make sure `~/.local/bin` is included in your shell's `PATH`, then start Neovim:

```bash
grep -qxF 'export PATH="$HOME/.local/bin:$PATH"' ~/.profile \
  || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
export PATH="$HOME/.local/bin:$PATH"
nvim
```

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
