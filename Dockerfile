
FROM ubuntu:latest

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        curl \
        unzip \
        tar \
        build-essential \
        ripgrep \
        universal-ctags \
        clang-format \
        clangd \
        nodejs \
        npm \
        && rm -rf /var/lib/apt/lists/*

# Install command-line tools that are unavailable or outdated in some Ubuntu
# repositories.
ARG TREE_SITTER_VERSION=0.27.1
ARG LAZYGIT_VERSION=0.66.2
RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "$ARCH" in \
        arm64) TREE_SITTER_ARCH="arm64"; LAZYGIT_ARCH="arm64" ;; \
        amd64) TREE_SITTER_ARCH="x64"; LAZYGIT_ARCH="x86_64" ;; \
        *) echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac; \
    curl -fL \
        "https://github.com/tree-sitter/tree-sitter/releases/download/v${TREE_SITTER_VERSION}/tree-sitter-cli-linux-${TREE_SITTER_ARCH}.zip" \
        -o /tmp/tree-sitter.zip; \
    unzip -o /tmp/tree-sitter.zip -d /usr/local/bin; \
    curl -fL \
        "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_${LAZYGIT_ARCH}.tar.gz" \
        -o /tmp/lazygit.tar.gz; \
    tar -C /usr/local/bin -xzf /tmp/lazygit.tar.gz lazygit; \
    chmod +x /usr/local/bin/tree-sitter /usr/local/bin/lazygit; \
    rm /tmp/tree-sitter.zip /tmp/lazygit.tar.gz

# Install latest stable Neovim
RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "$ARCH" in \
        arm64) NVIM_ARCH="arm64" ;; \
        amd64) NVIM_ARCH="x86_64" ;; \
        *) echo "Unsupported architecture: $ARCH"; exit 1 ;; \
    esac; \
    curl -fL \
        "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${NVIM_ARCH}.tar.gz" \
        -o /tmp/nvim.tar.gz; \
    tar -C /opt -xzf /tmp/nvim.tar.gz; \
    ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim; \
    rm /tmp/nvim.tar.gz; \
    nvim --version

# Install Neovim configuration
RUN git clone \
    https://github.com/LeonWandruschka/nvim-lua-config.git \
    /root/.config/nvim

# Working directory
WORKDIR /app

CMD ["/bin/bash"]
