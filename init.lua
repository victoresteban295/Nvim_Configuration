require "user.options"
require "user.keymaps"
require "user.plugins"
require "plugin-configs.nightfox-config" -- colorscheme config must be called first
require "user.colorscheme"
require "user.cmp"
require "user.lsp" -- For directory, it looks for init.lua
require "user.telescope"

-- Plugin Configurations 
require "plugin-configs.blankline-config"
require "plugin-configs.treesitter-config"
require "plugin-configs.colorizer-config"
require "plugin-configs.autopairs-config"
require "plugin-configs.comment-config"
require "plugin-configs.gitsigns-config"
require "plugin-configs.nvimTree-config"
require "plugin-configs.bufferline-config"
require "plugin-configs.toggleterm-config"
require "plugin-configs.lualine-config"
require "plugin-configs.impatient-config"
require "plugin-configs.alpha-config"
require "plugin-configs.whichkey-config"
require "plugin-configs.project-config"
