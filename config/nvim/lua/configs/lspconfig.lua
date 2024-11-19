local nvlsp = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

nvlsp.defaults() -- loads nvchad's defaults

local defaultServers = {
  "terraformls",
  "dockerls",
  "pyright",
}

-- lsps with default config
for _, lsp in ipairs(defaultServers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

lspconfig.helm_ls.setup({
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	settings = {
		["helm-ls"] = {
			-- logLevel = "debug",
			yamlls = {
				path = "yaml-language-server",
			},
		},
	},
})

lspconfig.yamlls.setup({
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	settings = {
		yaml = {
			format = {
				enable = true,
			},
			validate = true,
			hover = true,
			completion = true,
			schemaStore = {
				enable = true,
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})
