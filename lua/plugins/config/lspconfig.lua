local M = {}
local utils = require("core.utils")
--local lsp = require("lspconfig")
local lsp = vim.lsp

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
	utils.load_mappings("lspconfig", { buffer = bufnr })

	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "always",
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

-- disable semantic tokens
M.on_init = function(client, _)
	if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

lsp.config("lua_ls", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,

	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					[vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types"] = true,
					[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

lsp.config("pyright", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

lsp.config("ts_ls", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})

lsp.config("rust_analyzer", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	-- Server-specific settings. See `:help lspconfig.config`
	settings = {
		["rust-analyzer"] = {},
	},
})

lsp.config("clangd", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	-- Server-specific settings. See `:help lspconfig.config`
	settings = {
		["rust-analyzer"] = {},
	},
})

lsp.config("gopls", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	-- Server-specific settings. See `:help lspconfig.config`
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
})

lsp.config("volar", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})

lsp.config("emmet_language_server", {})

lsp.config("texlab", {
	on_init = M.on_init,
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	settings = {
		texlab = {
			bibtexFormatter = "texlab",
			build = {
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				executable = "latexmk",
				forwardSearchAfter = false,
				onSave = true,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 300,
			formatterLineLength = 80,
			forwardSearch = {
				args = {},
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = true,
			},
		},
	},
})

return M
