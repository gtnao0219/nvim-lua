local status, _ = pcall(require, 'nvim-treesitter')
if (not status) then return end

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua',
    'rust'
  },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
