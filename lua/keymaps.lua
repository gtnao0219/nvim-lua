vim.g.mapleader = " "
vim.keymap.set('n', '<Leader>', '<Nop>')
vim.keymap.set('x', '<Leader>', '<Nop>')

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
vim.keymap.set('x', ';', ':')
vim.keymap.set('x', ':', ';')

vim.keymap.set('n', '<Leader>h', '^')
vim.keymap.set('n', '<Leader>l', '$')

vim.keymap.set('n', '<Leader>w', [[<Cmd>update<CR>]])
vim.keymap.set('n', '<Leader>q', [[<Cmd>quit<CR>]])

vim.keymap.set('n', '<', '<<')
vim.keymap.set('n', '>', '>>')
vim.keymap.set('x', '<', '<<')
vim.keymap.set('x', '>', '>>')

vim.keymap.set('n', '<Leader>r', '[[<Cmd>luafile ~/.config/nvim/init.lua<CR>]]')
