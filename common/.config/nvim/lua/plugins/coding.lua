return {
  {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
      vim.cmd([[
        " Start interactive EasyAlign in visual mode (e.g. vipga)
        xmap ga <Plug>(EasyAlign)

        " Start interactive EasyAlign for a motion/text object (e.g. gaip)
        nmap ga <Plug>(EasyAlign)
      ]])
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      require("conform").setup({
        -- Map of filetype to formatters
        formatters_by_ft = {
          c = { "clang-format" },
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          go = { "goimports", "gofmt" },
          -- You can also customize some of the format options for the filetype
          rust = { "rustfmt", lsp_format = "fallback" },
          yaml = { "yamlfmt" },
          python = { "ruff_format" },
          toml = { "taplo" },
          -- Use the "*" filetype to run formatters on all filetypes.
          ["*"] = { "codespell" },
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other formatters configured.
          ["_"] = { "trim_whitespace" },
        },
        -- -- Set this to change the default values when calling conform.format()
        -- -- This will also affect the default values for format_on_save/format_after_save
        -- default_format_opts = {
        --   lsp_format = "fallback",
        -- },
        -- -- If this is set, Conform will run the formatter on save.
        -- -- It will pass the table to conform.format().
        -- -- This can also be a function that returns the table.
        format_on_save = {
          -- I recommend these options. See :help conform.format for details.
          lsp_format = "fallback",
          timeout_ms = 500,
        },
        -- -- If this is set, Conform will run the formatter asynchronously after save.
        -- -- It will pass the table to conform.format().
        -- -- This can also be a function that returns the table.
        -- format_after_save = {
        --   lsp_format = "never",
        -- },
        -- -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        -- log_level = vim.log.levels.ERROR,
        -- -- Conform will notify you when a formatter errors
        -- notify_on_error = true,
        -- -- Conform will notify you when no formatters are available for the buffer
        -- notify_no_formatters = true,
      })

      require("conform.formatters.clang-format").args = { "-style=mozilla", "-assume-filename", "$FILENAME" }
    end,
  },
  -- {
  --   -- Remove phpcs linter.
  --   "mfussenegger/nvim-lint",
  --   -- event = "VeryLazy",
  --   lazy = false,
  --   config = function()
  --     local phpstan = require("lint").linters.phpstan
  --     phpstan.args = {
  --       "analyze",
  --       "--error-format=json",
  --       "--no-progress",
  --       "-l9",
  --     }
  --     -- require("lint").linters_by_ft = {
  --     --   php = { "phpstan" },
  --     -- }
  --     vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --       callback = function()
  --         -- try_lint without arguments runs the linters defined in `linters_by_ft`
  --         -- for the current filetype
  --         require("lint").try_lint()
  --
  --         -- You can call `try_lint` with a linter name or a list of names to always
  --         -- run specific linters, independent of the `linters_by_ft` configuration
  --         -- require("lint").try_lint("cspell")
  --       end,
  --     })
  --   end,
  -- },
}