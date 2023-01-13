local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then 
    return
end

configs.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to 'ensure_installed')
    ignore_install = {""}, --List of parsers to ignore installing
    -- nvim-autopairs configs
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extention
        disable = {""}, -- list of languages that will be disabled
        additional_vim_regex_highlighting = true, 
    },
    -- Neovim ts Rainbow Plugin Config
    rainbow = {
        enable = true,
        disable = { "html", "jsx", "cpp" }, -- list of languages you want to disable the plugin for
        extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}

-- Overide Neovim ts Rainbow Colors
vim.cmd([[ autocmd FileType * highlight rainbowcol1 guifg=#ff3333 gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol2 guifg=#fffd33 gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol3 guifg=#20fd08 gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol4 guifg=#0834fd gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol5 guifg=#ffb100 gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol6 guifg=#ff00f2 gui=bold ]])
vim.cmd([[ autocmd FileType * highlight rainbowcol7 guifg=#00f7ff gui=bold ]])
