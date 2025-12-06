return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    opts = {
        win = {
            kind = 'split_left_most'
        },
    },
    init = function()
        vim.keymap.set('n', '<leader>e',
            function()
                require('fyler').toggle({ kind = 'split_left_most' })
            end,
            { desc = 'file explorer' }
        )
    end,
}
