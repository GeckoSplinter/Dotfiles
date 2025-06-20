return {
  { -- further customize the options set by the community
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      integrations = {
        sandwich = false,
        noice = true,
        mini = true,
        leap = true,
        markdown = true,
        neotest = true,
        cmp = true,
        overseer = true,
        lsp_trouble = true,
        rainbow_delimiters = true,
      },
    },
  },
}
