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
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if string.match(vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)), '^fyler:') then
                        return vim.api.nvim_win_close(win, false)
                    end
                end
                vim.cmd.Fyler()
            end,
            { desc = 'file explorer' }
        )
    end,
}
