return {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
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
        vim.o.conceallevel = 3
    end,
}
