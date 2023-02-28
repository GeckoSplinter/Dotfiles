local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fg', function ()
    require("telescope").extensions.live_grep_args.live_grep_raw()
end)

vim.keymap.set('n', '+', function()
    local ok = pcall(builtin.git_files)
    if not ok then builtin.find_files() end
end)

vim.keymap.set('v', '<leader>f', function()
    local text = vim.getVisualSelection()
    require("telescope").extensions.live_grep_args.live_grep_raw({ default_text = text })
end)

vim.keymap.set('', '<leader>h', builtin.resume, {})
vim.keymap.set('n', '<leader>!', builtin.git_status, {})
vim.keymap.set('n', '<leader>@', builtin.git_bcommits, {})

local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
