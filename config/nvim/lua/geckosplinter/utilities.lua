-- Utilities
local nnoremap = require('geckosplinter.keymap').nnoremap
local vnoremap = require('geckosplinter.keymap').vnoremap

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

--require("telescope").load_extension("emoji")
require("telescope").load_extension("live_grep_args")

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    sorting_strategy = "ascending",
    layout_strategy = 'vertical',
    layout_config = {
      mirror = true,
      prompt_position = "top"
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      '--ignore-file',
      '.gitignore'
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('spectre').setup{}

-- Mappings

nnoremap('<leader>s', require('spectre').open)
vnoremap('<leader>s', function()
    require('spectre').open_visual({ select_word = true })
end)

local keymapOptions = { noremap = true, silent = true }
nnoremap('<leader>ff', require('telescope.builtin').find_files)
nnoremap('<leader>fb', require('telescope.builtin').buffers)
nnoremap('<leader>fh', require('telescope.builtin').help_tags)
nnoremap('<leader>fg', function ()
    require("telescope").extensions.live_grep_args.live_grep_raw()
end)

nnoremap('+', function()
    local ok = pcall(require('telescope.builtin').git_files)
    if not ok then require('telescope.builtin').find_files() end
end)

vnoremap('<leader>f', function()
    local text = vim.getVisualSelection()
    require("telescope").extensions.live_grep_args.live_grep_raw({ default_text = text })
end)

vim.keymap.set('', '<leader>h', require('telescope.builtin').resume, keymapOptions)

nnoremap('<leader>!', require('telescope.builtin').git_status)
nnoremap('<leader>@', require('telescope.builtin').git_bcommits)
