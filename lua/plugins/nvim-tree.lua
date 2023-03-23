local function getconfig()
    local tree_cb = require'nvim-tree.config'.nvim_tree_callback

    require'nvim-tree'.setup {
        view = {
            mappings = {
                list = {
                    { key = {'l', '<cr>', 'o'}, cb = tree_cb 'edit' },
                    { key = 'h', cb = tree_cb 'close_node' },
                    { key = 'v', cb = tree_cb 'vsplit' },
                    { key = 's', cb = tree_cb 'split' },
                },
            },
        }
    }

    vim.keymap.set('n', '<c-n>', ':NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>')
    vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')
end

return {
    'kyazdani42/nvim-tree.lua',
    keys = {
        { '<c-n>', '<cmd>NvimTreeToggle', desc = 'nvim-tree' },
    },
    dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
        getconfig()
    end
}
