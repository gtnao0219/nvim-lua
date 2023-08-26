require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua',
    'rust',
    'tsx',
    'typescript',
  },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
}
