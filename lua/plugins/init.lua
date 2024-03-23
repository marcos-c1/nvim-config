local default_plugins = {
  -- load luasnips + cmp related in insert mode only (copy pasted from NvChad)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "plugins.config.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.config.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  'nvim-lua/plenary.nvim',
  {
    "NvChad/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require("nvterm").setup(opts)
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function()
      require("core.utils").load_mappings "bufferline"
    end,
    opts = function()
      return require "plugins.config.others".bufferline
    end, 
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },
  -- file explorer, picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.config.nvimtree"
    end,
    config = function(_, opts)
      --dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
    end,
  },

  -- themes
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
    config = function()
      require("moonbow")
     -- vim.cmd[[ colorscheme oxocarbon ]]
    end,
  },
  { 
    "Everblush/nvim",
    name = 'everblush',
    priority = 1000,
    config = function()
      require("everblush")
      -- vim.cmd[[ colorscheme everblush ]]
    end,
  },
  {
      "arturgoms/moonbow.nvim",
      priority = 1000,
      config = function()
        require("moonbow")
        vim.cmd[[ colorscheme moonbow ]]
      end,
  },
  { 
      "catppuccin/nvim", 
      name = "catppuccin", 
      priority = 1000,
      opts = function()
        return require "plugins.config.others".catppuccin
      end,
      config = function(_, opts)
        require("catppuccin").setup(opts)
        --vim.cmd[[ colorscheme catppuccin ]]
      end,
  },
  {
      "navarasu/onedark.nvim",
      priority = 1000,
      name = "onedark",
      opts = function()
        return require("plugins.config.others").onedark
      end,
      config = function(_, opts)
        require("onedark").setup(opts)
        --vim.cmd[[ colorscheme onedark ]]
      end,
  },
  {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      name = "gruvbox",
      opts = function()
        return require("plugins.config.others").gruvbox
      end,
      config = function(_, opts)
        require("gruvbox").setup(opts)
        --vim.cmd[[ colorscheme gruvbox ]]
      end,
  },

  -- statusline
  {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = function()
        return require "plugins.config.lualine"
      end,
      config = function(_, opts)
        require("lualine").setup(opts)
      end,
  }, 

  -- lazygit support to floatterm
  { "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    --event = "User FilePost",
    config = function()
      require "plugins.config.lspconfig"
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "plugins.config.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      --for _, ext in ipairs(opts.extensions_list) do
        --telescope.load_extension(ext)
      --end
    end,
  },

  -- icons wayy
  {
    "nvim-tree/nvim-web-devicons",
    --opts = function()
      --return { override = require "nvchad.icons.devicons" }
    --end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    --event = "User FilePost",
    opts = function()
      return require("plugins.config.others").blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      --dofile(vim.g.base46_cache .. "blankline")
      require("indent_blankline").setup(opts)
    end,
  },

  -- color syntax treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.config.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    --event = "User FilePost",
    opts = function()
      return require("plugins.config.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "plugins.config.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

   -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },
}

local config = require("core.utils").load_config()

if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

require("lazy").setup(default_plugins, config.lazy)
