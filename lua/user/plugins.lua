local fn = vim.fn

-- Automatically install packer 
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file 
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use 
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here 
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself 
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
    use "lukas-reineke/indent-blankline.nvim" -- A nvim plugin to display the indentation levels with thin vertical lines
    use "windwp/nvim-autopairs" -- Autopairs brackets, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim" -- Comment out plugin (works for most lang)
    use "nvim-tree/nvim-web-devicons" -- Enables icons for Nvim Tree
    use "nvim-tree/nvim-tree.lua" -- Nvim Tree Plugin
    use {
        "akinsho/bufferline.nvim", -- Buffer (Tabs) Plugin
        tag = "v3.5.0", -- v3.6.0 (latest) causes an error 
    }
    use "moll/vim-bbye" -- Plugin for Bufferline to close buffers w/o exiting Neovim
    use "nvim-lualine/lualine.nvim" -- Lualine Plugin (Provides a line in Neovim w/ information abt Modes)
    use "akinsho/toggleterm.nvim" -- Toggleterm Plugin (Neovim Popup Terminal)
    use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time
    use "goolord/alpha-nvim" -- Programmable greeter for Neovim
    use "antoinemadec/FixCursorHold.nvim" -- Needed to fix LSP doc highlight
    use "folke/which-key.nvim" -- Which-Key Plugin (Provides list of commands)
    use "windwp/nvim-ts-autotag" -- Autoclose tag for HTML Tags
    use "joosepAlviste/nvim-ts-context-commentstring" -- Appropriately Comment out JSX Content
    use "p00f/nvim-ts-rainbow" -- Rainbow Parentheses (*Archived Repository* FIND REPLACEMENT)
    use "lewis6991/gitsigns.nvim" -- Gitsigns (Powerful Git Plugin)
    use "norcalli/nvim-colorizer.lua" -- Highlights Color Hexcode with Coresponding Color
    use "EdenEast/nightfox.nvim" -- Colorscheme NighFox

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }

    --[[ -- LSP Plugins ]]
    --[[ use { ]]
    --[[     'vonheikemen/lsp-zero.nvim', -- Eliminates Need For LSP Boilerplate Code ]]
    --[[     branch = 'v2.x', ]]
    --[[     requires = { ]]
    --[[]]
    --[[         -- LSP Support ]]
    --[[         {'neovim/nvim-lspconfig'}, -- Enables LSP to Communicate with Neovim ]]
    --[[         { ]]
    --[[             'williamboman/mason.nvim', -- LSP Package Manager to Easily Install LSP Server & More ]]
    --[[             run = function() ]]
    --[[                 pcall(vim.cmd, 'masonupdate') ]]
    --[[             end, ]]
    --[[         }, ]]
    --[[         {'williamboman/mason-lspconfig.nvim'}, -- Bridges the Gap btw mason.nvim & nvim-lspconfig plugins ]]
    --[[]]
    --[[         -- Autocompletion ]]
    --[[         {'hrsh7th/nvim-cmp'},     -- Completion Engine for Neovim ]]
    --[[         {'hrsh7th/cmp-nvim-lsp'}, -- Engine that provides LSP Snippets ]]
    --[[         {'L3MON4D3/LuaSnip'},     -- ]]
    --[[     } ]]
    --[[ } ]]

    -- LSP Plugins (Manual Setup)
    use {
        "williamboman/mason.nvim", -- LSP Package Manager to Easily Install LSP Server & more
        "williamboman/mason-lspconfig.nvim", -- Bridges the Gap btw mason.nvim & nvim-lspconfig plugins 
        "neovim/nvim-lspconfig", -- Enables LSP to Communicate with Neovim
    }

    -- Autocompletion Plugins
    use "hrsh7th/nvim-cmp" -- Completion Engine for Neovim
    use "hrsh7th/cmp-nvim-lsp" -- Engine that provides LSP Snippets
    use "L3MON4D3/LuaSnip"

    use "mfussenegger/nvim-jdtls" -- Further Enable jdtls Configuration (To add Lombok)

    -- Telescope & Supporting Plugins
    use "nvim-telescope/telescope.nvim"
    use "ahmedkhalf/project.nvim" -- Required for ':Telescope projects' to find project directories
    use "nvim-telescope/telescope-file-browser.nvim" -- File Browser Extention for Telescope Plugin


    -- Automatically setup your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
