-- dofile(vim.g.base46_cache .. "lsp")
-- require "nvchad.lsp"

local M = {}
local utils = require "core.utils"
local lsp = require("lspconfig")

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  --if client.server_capabilities.signatureHelpProvider then
    --require("nvchad.signature").setup(client)
  --end
end

-- disable semantic tokens
M.on_init = function(client, _)
  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
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

lsp.lua_ls.setup {
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
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lsp.pyright.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
 
}

lsp.tsserver.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,

}

lsp.rust_analyzer.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

lsp.clangd.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

lsp.gopls.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

lsp.vuels.setup {
  on_init = M.on_init,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  
  settings = {
            vetur = {
                completion = {
                    autoImport = true,
                    useScaffoldSnippets = true
                },
                format = {
                    defaultFormatter = {
                        html = "none",
                        js = "prettier",
                        ts = "prettier",
                    }
                },
                validation = {
                    template = true,
                    script = true,
                    style = true,
                    templateProps = true,
                    interpolation = true
                },
                experimental = {
                    templateInterpolationService = true
                }
            }
        },
}

lsp.emmet_language_server.setup{}

return M
