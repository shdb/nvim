return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        vim.keymap.set('n', '<leader>ff', require("telescope.builtin").find_files, { desc = 'telescope find file' })
        vim.keymap.set('n', '<leader>fg', require("telescope.builtin").live_grep,  { desc = 'telescope grep' })
        vim.keymap.set('n', '<leader>fb', require("telescope.builtin").buffers,    { desc = 'telescope buffers' })
        vim.keymap.set('n', '<leader>fh', require("telescope.builtin").help_tags,  { desc = 'telescope help' })
        vim.keymap.set('n', '<leader>fn',
            function()
                require("telescope.builtin").find_files {
                    cwd = vim.fn.stdpath('config')
                }
            end,
            { desc = 'telescope neovim config' }
        )
    end
}
