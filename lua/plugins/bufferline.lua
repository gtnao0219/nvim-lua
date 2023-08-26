local bufferline = require('bufferline')
bufferline.setup({
  options = {
    separator_style = 'slant',
    diagnostics = 'nvim_lsp',
  },
})
vim.keymap.set('n', '<C-b>l', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-b>h', '<Cmd>BufferLineCyclePrev<CR>')
