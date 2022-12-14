local M = {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        -- 'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        -- 'hrsh7th/cmp-cmdline',
        {
            'saadparwaiz1/cmp_luasnip',
            dependencies = { 'L3MON4D3/LuaSnip', "rafamadriz/friendly-snippets" },
        },
    }
}

function M.config()
    vim.opt.completeopt = { "menu", "menuone", "noselect" }

    -- Set up nvim-cmp.
    local luasnip = require('luasnip')
    local ok_cmp, cmp = pcall(require, 'cmp')
    local select_opts = {}
    local s = {}

    if not ok_cmp then
        local msg = "[lsp-zero] Could not find nvim-cmp. Please install nvim-cmp or set the option `manage_nvim_cmp` to false."
        vim.notify(msg, vim.log.levels.WARN)
    else
        select_opts = {behavior = cmp.SelectBehavior.Select}
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

            -- go to next placeholder in the snippet
            ['<C-d>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, {'i', 's'}),
            -- go to previous placeholder in the snippet
            ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {'i', 's'}),

            -- when menu is visible, navigate to next item
            -- when line is empty, insert a tab character
            -- else, activate completion
            -- ['<Tab>'] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_next_item(select_opts)
            --     elseif s.check_back_space() then
            --         fallback()
            --     end
            -- end, {'i', 's'}),
            -- ['<S-Tab>'] = cmp.mapping(function(fallback)
            --     if cmp.visible() then
            --         cmp.select_prev_item(select_opts)
            --     else
            --         fallback()
            --     end
            -- end, {'i', 's'}),
        }),
        sources = cmp.config.sources({
            {name = 'path'},
            -- {name = 'nvim_lsp', keyword_length = 3},
            {name = 'nvim_lsp'},
            -- {name = 'buffer', keyword_length = 3},
            {name = 'buffer'},
            -- {name = 'luasnip', keyword_length = 2},
            {name = 'luasnip'},
        })
    })
end

return M
