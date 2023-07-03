---@type MappingsTable
local M = {}

M.disabled = {
	i = {
		-- not working :/
		["<Up>"] = { "<ESC>", "disable arrow in isert mode", opts = { nowait = true } },
		["<Down>"] = { "<ESC>", "disable arrow in isert mode", opts = { nowait = true } },
		["<Left>"] = { "<ESC>", "disable arrow in isert mode", opts = { nowait = true } },
		["<Right>"] = { "<ESC>", "disable arrow in isert mode", opts = { nowait = true } },
	},
}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } }, },
	v = {
		["J"] = { ":m '>+1<CR>gv=gv", "move highlighted line down" },
		["K"] = { ":m '<-2<CR>gv=gv", "move highlighted line up" },
		["<C-r>"] = { '"hy:%s/<C-r>h//gc<left><left><left>', "replace in visual mode" },
	},
}

M.git = {
	n = {
		-- git status from fugitive
		["<leader>gs"] = { vim.cmd.Git, "Git status" },
		["<leader>gu"] = { ":Git pull --rebase origin master<CR>", "Pull update from master on br" },
		["<leader>ga"] = { "<cmd>!git fetch --all<CR>", "Fetch all updates" },
		["<leader>gh"] = { ":<cmd>!gh pr create -f <CR>", "Open PR on github from curent branch" },
	},
}


local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
	group = ThePrimeagen_Fugitive,
	pattern = "*",
	callback = function()
		if vim.bo.ft ~= "fugitive" then
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("push")
		end, opts)

		-- rebase always
		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git("pull --rebase")
		end, opts)

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
	end,
})
-- more keybinds!
M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add breakpoint at line",
		},
		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open debugging sidebar",
		},
	},
}

M.dap_go = {
	plugin = true,
	n = {
		["<leader>dgt"] = {
			function()
				require("dap-go").debug_test()
			end,
			"Debug go test",
		},
		["<leader>dgl"] = {
			function()
				require("dap-go").debug_last()
			end,
			"Debug last go test",
		},
	},
}

M.gopher = {
	plugin = true,
	n = {
		["<leader>gsj"] = {
			"<cmd> GoTagAdd json <CR>",
			"Add json struct tags",
		},
		["<leader>gsy"] = {
			"<cmd> GoTagAdd yaml <CR>",
			"Add yaml struct tags",
		},
	},
}

return M
