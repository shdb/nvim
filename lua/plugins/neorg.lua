return {
    'nvim-neorg/neorg',
    enabled = false,
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    dependencies = { -- https://github.com/nvim-neorg/neorg/issues/1808
        'nvim-neorg/tree-sitter-norg',
        'nvim-neorg/tree-sitter-norg-meta',
    },
    config = function ()
        require('neorg').setup({
            load = {
                ['core.defaults'] = {},
                ['core.concealer'] = {
                    config = {
                        folds = false,
                    },
                },
                ['core.dirman'] = {
                    config = {
                        workspaces = {
                            notes = '~/notes',
                        },
                    },
                },
            },
        })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                vim.opt_local.conceallevel = 3
            end,
        })
    end,
}
