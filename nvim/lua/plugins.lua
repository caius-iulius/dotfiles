return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        }
        --tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use{
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    }

    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }--use 'rust-lang/rust.vim'
    --use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

    use {
        'simrat39/rust-tools.nvim',
        requires = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'mfussenegger/nvim-dap'
        }
    }

    use 'caius-iulius/haskell-vim'

    use 'joshdick/onedark.vim'
end)
