return {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPost",
    dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
        require('gitsigns').setup()
    end
}
