local status, nvim_tree = pcall(require, 'nvim-tree')
if (not status) then return end

vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)
nvim_tree.setup {
  sort_by = 'extension',
  view = {
    side = 'right',
  },
}
vim.keymap.set('n', '<C-n>', '<Cmd>NvimTreeToggle<CR>')
