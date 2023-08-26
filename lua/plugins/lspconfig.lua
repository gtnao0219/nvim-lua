require('mason').setup()
require('mason-null-ls').setup({
  ensure_installed = { 'prettier' },
  automatic_installation = true,
})
require('null-ls').setup({
  sources = {
    require('null-ls').builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
  },
})
require('mason-lspconfig').setup {
  ensure_installed = {
    "eslint",
    "lua_ls",
    "rust_analyzer",
    "solargraph",
    "tsserver",
  },
  automatic_installation = true,
}

local lspconfig = require('lspconfig')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
  settings = {
    preferences = {
      importModuleSpecifierPreference = "non-relative"
    },
  }
}
lspconfig.eslint.setup {
  capabilities = capabilities,
}
lspconfig.solargraph.setup {
  capabilities = capabilities,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>fm', function()
      if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' or vim.bo.filetype == 'typescript.tsx' then
        vim.cmd([[EslintFixAll]])
      end
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- TODO: format on save
-- https://github.com/neovim/nvim-lspconfig/issues/1792#issuecomment-1352782205
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   buffer = buffer,
--   callback = function()
--     vim.lsp.buf.format { async = false }
--   end
-- })
