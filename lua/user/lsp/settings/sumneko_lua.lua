return {
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Prevent Undefined Global Error 
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
