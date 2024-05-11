local function getconfig()
    local actions = require 'telescope.actions'

    require('telescope').setup{
        defaults = {
            mappings = {
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<C-n>'] = actions.cycle_history_next,
                    ['<C-p>'] = actions.cycle_history_prev,
                    ['<C-s>'] = actions.select_horizontal,
                },
            },
        },
    }

    vim.keymap.set('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>')
    vim.keymap.set('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
    vim.keymap.set('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>')
    vim.keymap.set('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>')
end

return {
    'nvim-telescope/telescope.nvim',
    keys = {
        { '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', desc = 'telescope find files' },
        { '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>',  desc = 'telescope live grep' },
        { '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>',    desc = 'telescope buffers' },
        { '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>',  desc = 'telescope help tags' },
    },
    config = function()
        getconfig()
    end
}
