local mason_status, mason = pcall(require, "mason")
if (not mason_status) then return end
local mason_lsp_config_status, mason_lsp_config = pcall(require, "mason-lspconfig")
if (not mason_lsp_config_status) then return end
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if (not lspconfig_status) then return end

mason.setup()
mason_lsp_config.setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer"
  },
  automatic_installation = true,
}

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}
lspconfig.rust_analyzer.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>df', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>rf', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- https://github.com/neovim/nvim-lspconfig/issues/1792#issuecomment-1352782205
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})
