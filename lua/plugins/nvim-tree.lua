vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)
require('nvim-tree').setup {
  sort_by = 'extension',
  update_focused_file = {
    enable = true,
  },
  -- view = {
  --   side = 'right',
  -- },
}
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')
