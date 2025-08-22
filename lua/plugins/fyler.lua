return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        require('fyler').setup {
            views = {
                explorer = {
                    win = {
                        kind = 'split_left_most',
                    },
                },
            },
        }

        vim.keymap.set('n', '<leader>e',
            function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if string.match(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)), '^fyler:') then
                        return vim.api.nvim_win_close(win, false)
                    end
                end
                require('fyler').open()
            end,
            { desc = 'file explorer' }
        )
    end,
}
