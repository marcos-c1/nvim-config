local k = vim.keymap
local M = {}

-------------------------- mapping ----------------------
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

M.load_mappings = function()
  -- Telescope 
  k.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { noremap = true, silent = true })
  k.set("n", "<leader>fg", "<cmd> Telescope live_grep <CR>", { noremap = true, silent = true })
  k.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { noremap = true, silent = true })
  k.set("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { noremap = true, silent = true })
  k.set("n", "<leader>gs", "<cmd> Telescope git_status <CR>", { noremap = true, silent = true })

  -- Lazygit
  k.set("n", "<Tab>", "<cmd> LazyGit <CR>", { noremap = true, silent = true })
end

return M
