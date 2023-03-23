return {
    'lewis6991/gitsigns.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
        require('gitsigns').setup()
    end
}
