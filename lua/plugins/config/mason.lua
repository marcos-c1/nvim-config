local options = {
	-- mason.lspconfig
	ensure_installed = {
		-- lsp
		"lua-language-server",
		"vim-language-server",
		"typescript-language-server",
		"emmet-language-server",
		"pyright",
		"gopls",
		"rust-analyzer",
		"tailwindcss-language-server",
		"clangd",
		"phpactor",
		"svelte-language-server",

		-- formatters
		"stylua",
		"gofumpt",
		"goimports",
		"goimports-reviser",
		"golines",
		"markdownlint",
		"prettier",
		"rustfmt",
		"shfmt",
		"jq",
		"isort",
		"black",
		"clang-format",
		"php-cs-fixer",
	}, -- not an option from mason.nvim

	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},

		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},

	max_concurrent_installers = 10,
}

return options
