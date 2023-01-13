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
    use "kyazdani42/nvim-web-devicons" -- Enables icons for Nvim Tree
    use "kyazdani42/nvim-tree.lua" -- Nvim Tree Plugin
    use "akinsho/bufferline.nvim" -- BufferLine Plugin
    use "moll/vim-bbye" -- Plugin for Bufferline to close buffers w/o exiting Neovim
    use "nvim-lualine/lualine.nvim" -- Lualine Plugin (Provides a line in Neovim w/ information abt Modes)
    use "akinsho/toggleterm.nvim" -- Toggleterm Plugin (Neovim Popup Terminal)
    use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time
    use "goolord/alpha-nvim" -- Programmable greeter for Neovim
    use "antoinemadec/FixCursorHold.nvim" -- Needed to fix LSP doc highlight
    use "folke/which-key.nvim" -- Which-Key Plugin (Provides list of commands)
    use "windwp/nvim-ts-autotag" -- Autoclose tag for HTML Tags
    use "ahmedkhalf/project.nvim" -- Required for ':Telescope projects'
    use "nvim-telescope/telescope-file-browser.nvim" -- File Browser Extention for Telescope Plugin
    
    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use "joosepAlviste/nvim-ts-context-commentstring" -- Appropriately Comment out JSX Content


    -- Rainbow Parentheses
    use "p00f/nvim-ts-rainbow"
    
    -- Colorscheme NightFox
    use "EdenEast/nightfox.nvim"

    -- use {
    --    "EdenEast/nightfox.nvim",
    --    tag = "v1.0.0",
    -- }

    -- Nvim Colorizer (Highights Color Your Using)
    use "norcalli/nvim-colorizer.lua"
 
    -- Completion Plugins
    use "hrsh7th/nvim-cmp" -- the completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- LSP completions 
    use "hrsh7th/cmp-nvim-lua" -- Lua completions 


    -- Snippets (Required for Completions)
    use "L3MON4D3/LuaSnip" -- snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use


    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "jose-elias-alvarez/null-ls.nvim" -- Null-LS Plugin


    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Gitsigns (Powerful Git Plugin)
    use "lewis6991/gitsigns.nvim"
    
    -- Automatically setup your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then 
        require("packer").sync()
    end 
end)
