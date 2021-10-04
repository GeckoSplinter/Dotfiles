local on_attach = require'completion'.on_attach

require'lspconfig'.terraformls.setup{
  on_attach=on_attach,
  cmd = {'terraform-ls', 'serve'}
}
-- require'lspconfig'.sumneko_lua.setup{ on_attach=on_attach }
require'lspconfig'.dockerls.setup{ on_attach=on_attach }
require'lspconfig'.gopls.setup{ on_attach=on_attach }
-- require'lspconfig'.yamlls.setup{
-- on_attach = on_attach }
--   settings = {
--     yaml = {
--       schemas = { kubernetes = "/*.yaml"},
--     },
--   },
-- }
