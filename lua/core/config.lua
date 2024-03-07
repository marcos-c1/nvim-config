local M = {}
local file = vim.fn.expand('%')

M.ui = {
  -- cmp themeing
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },

  nvterm = {
    python = "python3 " .. file,
    rust = "cargo run " .. file,
    c = "gcc -c -o " .. file,
    cpp = "g++ -c -o " .. file,
    bash = "./" .. file,
    go = "go run ".. file,
    javascript = "node " .. file,
    java = "javac " .. file,
  },
}

M.plugins = ""
M.mappings = require "core.mappings"
M.lazy = require "plugins.config.lazy_nvim" 

return M
