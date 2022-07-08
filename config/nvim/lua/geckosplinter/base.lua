vim.opt.fileformats = 'unix'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.autoread = true
vim.opt.colorcolumn = '120'
-- highlight ColorColumn ctermbg=0 guibg=grey

vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.errorbells = false

-- Tab ans indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Undo and swap
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd [[
  colorscheme gruvbox
  syntax on
  hi Normal guibg=NONE ctermbg=NONE
]]

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Give more space for displaying messages.
vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append("c")


-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd(
  'BufReadPost',
  {
    pattern = {'*'},
    callback = function()
      local ft = vim.opt_local.filetype:get()
      -- don't apply to git messages
      if (ft:match('commit') or ft:match('rebase')) then
        return
      end
      -- get position of last saved edit
      local markpos = vim.api.nvim_buf_get_mark(0,'"')
      local line = markpos[1]
      local col = markpos[2]
      -- if in range, go there
      if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
        vim.api.nvim_win_set_cursor(0,{line,col})
      end
    end
  }
  )
