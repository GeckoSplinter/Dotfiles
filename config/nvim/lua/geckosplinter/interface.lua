-- Interface settings / plugins
local nnoremap = require('geckosplinter.keymap').nnoremap

-- Lua line
require('lualine').setup({
    options = { theme = 'gruvbox' }
  })

-- Devicons
require('nvim-web-devicons').setup {
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- Nvim tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
nnoremap('<C-n>', ':NvimTreeToggle<CR>');
nnoremap('<leader>r', ':NvimTreeRefresh<CR>');
nnoremap('<leader>n', ':NvimTreeFindFile<CR>');

-- Blankline
require("indent_blankline").setup {
  space_char_blankline = " ",
  buftype_exclude = {"terminal"},
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true
}
