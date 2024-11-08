-- only contains lazy and plugin config.
require("config.remap")
require("config.autocmd")
require("config.commands")

-- disable diagnostics by default (<leader>d to toggle)
vim.diagnostic.enable(false)

-- lazy config
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "config.lazy",
    change_detection = { notify = true }
})

-- mason
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { -- other installed: cpplint
        "asm_lsp",
        "lua_ls",
        "clangd",
        "bashls",
        "marksman",
        "ruff",
        "pyright",
        "eslint",
        "rust_analyzer",
        "gopls",
        "zls",
    },
})

-- lspconfig
local lspconf = require("lspconfig")
lspconf.bashls.setup({})
lspconf.clangd.setup({})
lspconf.marksman.setup({})
lspconf.pyright.setup({})
-- lspconf.ruff.setup({})
lspconf.eslint.setup({})
lspconf.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "it", }
            },
        },
    },
})
lspconf.rust_analyzer.setup({})
lspconf.gopls.setup({})
lspconf.zls.setup({})

-- notification UI
require("fidget").setup()

-- cmp
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local defaults = require("cmp.config.default")()
cmp.setup({
    completion = {
        autocomplete = false
    },
    enabled = function()
        -- disable completion in comments
        local context = require("cmp.config.context")
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<S-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ['<C-CR>'] = function(fallback)
            cmp.abort()
            fallback()
        end,
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    }, { name = 'buffer' }),
    sorting = defaults.sorting,
})

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- colorscheme
require("rose-pine").setup(
    {
        variant = "main",
        enable = {
            terminal = true,
            migration = true,
        },
        styles = {
            bold = true,
            italic = false,
        },
        disable_background = true,
    }
)
require("kanagawa").setup({
    undercurl = true,
    commentStyle = { italic = false },
    keywordStyle = { italic = false, bold = true },
    statementStyle = { bold = false },
    transparent = true,
    dimInactive = true,
    theme = "dragon",
    background = { dark = "dragon", light = "lotus" },
})

require("solarized-osaka").setup({
    transparent = true,
    on_colors = function(colors)
        colors.red = "#97444B"
    end
})
vim.cmd("colorscheme kanagawa")

-- colorizer
require("colorizer").setup()
