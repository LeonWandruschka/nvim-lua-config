
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
        tree-sitter-cli \
        && rm -rf /var/lib/apt/lists/*

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

