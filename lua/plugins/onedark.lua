return {
    'navarasu/onedark.nvim',
    config = function()
        require('onedark').setup {
            colors = {
                shdb_darkgreen = '#008700',
                shdb_darkergreen = '#005f00',
                shdb_black = '#000000',
                shdb_green = '#00ff00',
                green = '#cc0403',  -- red
                fg = '#00ff00',     -- matrix green
                bg0 = '#000000',    -- black
                bg1 = '#111111',
                bg2 = '#111111',
                bg3 = '#111111',
                purple = '#cecb00', -- yellow
                red = '#0dcbcb',    -- cyan
                grey = '#0d72ca',   -- blue
                orange = '#008700', -- darkgreen
            },

            highlights = {
                Search = {fg = '$shdb_black', bg = '$shdb_darkgreen'},
                IncSearch = {fg = '$shdb_black', bg = '$shdb_darkgreen'},
                VertSplit = {fg = '$shdb_green'},
                Visual = {bg='$shdb_darkergreen'},
                LineNrAbove = { fg = '$shdb_darkergreen' },
                --LineNr = { fg = '$shdb_green' },
                LineNr = { fg = '$shdb_darkergreen' },
                LineNrBelow = { fg = '$shdb_darkergreen' },
                --CursorLine = { fg = 'NONE', bg = 'NONE' },
            }
        }
        vim.cmd('colorscheme onedark')
    end
}
