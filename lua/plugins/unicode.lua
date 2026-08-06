return {
    'ghassan0/telescope-glyph.nvim',
    keys = {
        {
            '<leader>fu',
            function()
                require('telescope').load_extension('glyph').glyph()
            end,
            desc = 'telescope unicode'
        }
    },
}
