require("indent_blankline").setup {
  space_char_blankline = " ",
  buftype_exclude = {"terminal"},
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter = true,
  --char_highlight_list = {
  --      "IndentBlanklineIndent1",
  --      "IndentBlanklineIndent2",
  --      "IndentBlanklineIndent3",
  --      "IndentBlanklineIndent4",
  --      "IndentBlanklineIndent5",
  --      "IndentBlanklineIndent6",
  --  },
}
