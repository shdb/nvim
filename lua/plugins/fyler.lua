return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {
        integrations = { icon = 'mini_icons' },
        kind = 'split_left_most',
    },
    keys = {
        {
            '<leader>e',
            function()
                require('fyler').toggle({ kind = 'split_left_most' })
            end,
            desc = 'file explorer'
        }
    }
}
