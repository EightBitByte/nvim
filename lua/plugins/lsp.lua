return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Set up Mason
    require("mason").setup()

    -- Ensure required LSPs are installed
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "clangd", "ts_ls", "omnisharp" },
      automatic_installation = true,
    })

    -- Configure LSPs
    local lspconfig = require("lspconfig")
    local servers = { "lua_ls", "pyright", "clangd", "ts_ls", "omnisharp" }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({})
    end

    -- Configure diagnostics settings
    vim.diagnostic.config({
      virtual_text = true, -- Show inline virtual text (errors, warnings, etc.)
      signs = true, -- Show diagnostic signs in the gutter (left side)
      update_in_insert = true, -- Update diagnostics while in insert mode
      underline = true, -- Underline text with diagnostics
      severity_sort = true, -- Sort diagnostics by severity
      float = {
        border = 'rounded', -- Add a rounded border to the floating window
        source = 'always', -- Always show source of the diagnostic
        header = '', -- No header for floating window
        prefix = '➤', -- Use a custom prefix for the diagnostics
      },
    })

    -- Define a global function for the diagnostics status
    function _G.diagnostics_status()
      local diagnostics = vim.diagnostic.get(0)
      local error_count = 0
      local warning_count = 0
      local info_count = 0
      local hint_count = 0

      for _, diag in ipairs(diagnostics) do
        if diag.severity == vim.diagnostic.severity.ERROR then
          error_count = error_count + 1
        elseif diag.severity == vim.diagnostic.severity.WARN then
          warning_count = warning_count + 1
        elseif diag.severity == vim.diagnostic.severity.INFO then
          info_count = info_count + 1
        elseif diag.severity == vim.diagnostic.severity.HINT then
          hint_count = hint_count + 1
        end
      end

      -- Return a formatted string showing counts
      return string.format("E:%d W:%d I:%d H:%d", error_count, warning_count, info_count, hint_count)
    end

    -- Use the function in the statusline
    vim.o.statusline = "%{v:lua.diagnostics_status()}"

    -- Define signs (customize these as you like)
    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

    -- Show diagnostics in a floating window on hover
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })
  end
}
