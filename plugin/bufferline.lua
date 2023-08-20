local bufferline_status, bufferline = pcall(require, "bufferline")
if (not bufferline_status) then return end

bufferline.setup({
  options = {
    separator_style = 'slant',
    diagnostics = 'nvim_lsp',
  }
})

vim.keymap.set('n', '<C-b>l', '<Cmd>BufferLineCycleNext<CR>')
vim.keymap.set('n', '<C-b>h', '<Cmd>BufferLineCyclePrev<CR>')
