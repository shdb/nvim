return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        require('fyler').setup {
            mappings = {
                explorer = {
                        ['<leader>e'] = 'CloseView',
                },
            },
            views = {
                explorer = {
                    win = {
                        kind = 'split_left_most',
                    },
                },
            },
        }
        vim.keymap.set('n', '<leader>e', ':Fyler<cr>', { desc = 'file explorer' })
    end,
}
