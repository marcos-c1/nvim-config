local options = {
	formatters_by_ft = {
		svg = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "jq" },
		yaml = { "prettier" },
		markdown = { "markdownlint" },
		graphql = { "prettier" },
		lua = { "stylua" },
		go = { "gofumpt", "golines", { "goimports", "goimports-reviser" } },
		rust = { "rustfmt" },
		cpp = { "clang-format" },
		c = { "clang-format" },
		bash = { "shfmt" },
		php = { "php-cs-fixer" },
		-- run only the first available with double brackets
		python = { { "isort", "black" } },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
		async = false,
	},
}

return options
