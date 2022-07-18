-- Completion: LSP Snippets CMP and treesitter
--


-- LSP config

require('nvim-lsp-installer').setup {
    automatic_installation = true -- detect lsp server configured here
} -- to be called before lspconfig

require('fidget').setup {}
local lspconfig = require("lspconfig")

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local handlers =  {
    -- ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {}),
    ["textDocument/codeAction"] = require'lspactions'.codeaction
}

local on_attach = function(client, bufnr)
    local lspactions = require'lspactions'

    if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable(bufnr)
        vim.defer_fn(function()
            vim.diagnostic.reset(nil, bufnr)
        end, 1000)
    end

    -- Mappings.
    local opts = { noremap=true, silent=true }
    vim.keymap.set('', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('', '<leader>rn', lspactions.rename, opts)
    vim.keymap.set('n', '<leader>a', lspactions.code_action, opts)
    vim.keymap.set('v', '<leader>a', lspactions.range_code_action, opts)
    vim.keymap.set('', '<leader>fo', vim.lsp.buf.formatting, opts)
end

lspconfig.sumneko_lua.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                preloadFileSize = 1000,
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
            completion = {
                keywordSnippet="Replace",
                callSnippet="Replace"
            },
        }
    }
}

lspconfig.jsonls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
        },
    },
}

lspconfig.bashls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.dockerls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.yamlls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.vimls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.terraformls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.gopls.setup {
    handlers = handlers,
    on_attach = on_attach,
    capabilities = capabilities,
}


local lspkind = require('lspkind')
vim.cmd [[ autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync() ]]


-- Snippets

local luasnip = require 'luasnip'
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })


-- Treesitter

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
    install_info = {
        url = "https://github.com/ngalaiko/tree-sitter-go-template",
        files = {"src/parser.c"}
    },
    filetype = "gotmpl",
    used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "hcl", "lua", "go", "yaml"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- CMP

local cmp = require 'cmp'

cmp.setup {
    sources = {
        { name = "nvim_lsp", priority = 90 },
        { name = 'luasnip', priority = 100 },
        { name = "buffer" },
        { name = "emoji" },
        { name = "path" },
        { name = "treesitter" },
        { name = 'nvim_lua' }
    },

    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

}

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-previous-choice", {})
vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-previous-choice", {})
