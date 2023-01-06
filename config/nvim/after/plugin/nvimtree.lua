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
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>');
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>');
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>');

