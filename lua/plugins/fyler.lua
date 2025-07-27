return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        require('fyler').setup {
            mappings = {
                explorer = {
                    n = {
                        ['<leader>e'] = 'CloseView',
                    },
                },
            },
            views = {
                explorer = {
                    width = 0.2,
                    height = 1,
                    kind = 'split:leftmost',
                    border = 'single',
                },
            },
        }
        vim.keymap.set('n', '<leader>e', ':Fyler<cr>', { desc = 'file explorer' })
    end,
}
