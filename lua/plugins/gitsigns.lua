return {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPost",
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
        require('gitsigns').setup()
    end
}
