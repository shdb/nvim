return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        vim.keymap.set('n', '<leader>ff', require("telescope.builtin").find_files)
        vim.keymap.set('n', '<leader>fg', require("telescope.builtin").live_grep)
        vim.keymap.set('n', '<leader>fb', require("telescope.builtin").buffers)
        vim.keymap.set('n', '<leader>fh', require("telescope.builtin").help_tags)
        vim.keymap.set('n', '<leader>en', function()
            require("telescope.builtin").find_files {
                cwd = vim.fn.stdpath('config')
            }
        end)
    end
}
