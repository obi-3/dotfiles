return {
  "nvim-lua/plenary.nvim",
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local presets = require("which-key.plugins.presets")
      presets.operators["v"] = nil
      presets.operators["d"] = nil
      presets.operators["c"] = nil
      require("which-key").setup({
        triggers = { "<leader>" },
      })
    end,
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },

  -- {
  --   "notjedi/nvim-rooter.lua",
  --   -- event = "BufWinEnter",
  --   cond = vim.api.nvim_command_output("!git rev-parse --is-inside-work-tree"),
  --   config = function()
  --     require("nvim-rooter").setup({
  --       rooter_patterns = { ".git", ".hg", ".svn" },
  --       trigger_patterns = { "*" },
  --       manual = false,
  --     })
  --   end,
  -- },

  {
    "tpope/vim-repeat",
    event = "InsertEnter",
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufRead", "InsertEnter" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "junegunn/vim-easy-align",
    event = "BufReadPre",
    config = function()
      vim.keymap.set("x", "<leader>a", "<Plug>(EasyAlign)", { noremap = true })
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "vim" },
        enable_moveright = true,
        map_c_h = true,
        check_ts = true,
      })
      require("nvim-autopairs").remove_rule("'")
      require("nvim-autopairs").remove_rule('"')
    end,
  },

  {
    'phaazon/hop.nvim',
    version = 'v2', -- optional but strongly recommended
    event = { "BufRead", "InsertEnter" },
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      -- place this in one of your configuration file(s)
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
      end, { remap = true })
    end
  },

  {
    'cappyzawa/trim.nvim',
    event = 'BufWritePre',
    config = function()
      require('trim').setup({
        -- disable = { "markdown" },
        -- if you want to remove multiple blank lines
        patterns = {
          [[%s/\(\n\n\)\n\+/\1/]], -- replace multiple blank lines with a single line
        },
      })
    end
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = { "BufRead", "InsertEnter" },
    config = function()
      require 'colorizer'.setup()
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = { "BufRead", "InsertEnter" },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require 'todo-comments'.setup({
        keywords = {
          FIX = {
            icon = " ",                              -- icon used for the sign, and in search results
            color = "error",                            -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })
    end,
  },

  {
    'echasnovski/mini.cursorword',
    version = '*',
    event = "VeryLazy",
    config = function()
      require('mini.cursorword').setup({
        delay = 100,
      })

      _G.cursorword_blocklist = function()
        local curword = vim.fn.expand('<cword>')
        local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

        -- Add any disabling global or filetype-specific logic here
        local blocklist = {}
        if filetype == 'lua' then
          blocklist = { 'local', 'require', 'vim' }
        elseif filetype == 'javascript' then
          blocklist = { 'import' }
        end

        vim.b.minicursorword_disable = vim.tbl_contains(blocklist, curword)
      end

      -- Make sure to add this autocommand *before* calling module's `setup()`.
      vim.cmd('au CursorMoved * lua _G.cursorword_blocklist()')
    end

  },

}
