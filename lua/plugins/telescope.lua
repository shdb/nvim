return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    keys = {
        {
            '<leader>ff',
            function()
                require("telescope.builtin").find_files()
            end,
            desc = 'telescope find file'
        },
        {
            '<leader>fg',
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = 'telescope grep'
        },
        {
            '<leader>fb',
            function()
                require("telescope.builtin").buffers()
            end,
            desc = 'telescope buffers'
        },
        {
            '<leader>fh',
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = 'telescope help'
        },
        {
            '<leader>fn',
            function()
                require("telescope.builtin").find_files {
                    cwd = vim.fn.stdpath('config')
                }
            end,
            desc = 'telescope neovim config'
        },
    }
}
