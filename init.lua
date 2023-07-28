require "user.options"
require "user.keymaps"
require "user.plugins"
require "plugin_configs.nightfox_config" -- colorscheme config must be called first
require "user.colorscheme"
require "user.cmp"
--[[ require "user.lsp" -- For directory, it looks for init.lua (Comment after installing lsp-zero) ]]
require "user.telescope"

-- Plugin Configurations 
require "plugin_configs.blankline_config"
require "plugin_configs.treesitter_config"
require "plugin_configs.colorizer_config"
require "plugin_configs.autopairs_config"
require "plugin_configs.comment_config"
require "plugin_configs.gitsigns_config"
require "plugin_configs.nvimTree_config"
require "plugin_configs.bufferline_config" -- Causes E5248: Invalid character in group name
require "plugin_configs.toggleterm_config"
require "plugin_configs.lualine_config"
require "plugin_configs.impatient_config"
require "plugin_configs.alpha_config"
require "plugin_configs.whichkey_config"
require "plugin_configs.project_config"
require "plugin_configs.lsp_config" -- Lsp Manual Setup
require "plugin_configs.dap_config"
