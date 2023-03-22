local vi_mode_utils = require('feline.providers.vi_mode')

local M = {
    active = {},
    inactive = {},
}

M.active[1] = {
    {
        --provider = '▊ ',
        provider = ' ',
        hl = {
            fg = 'green',
        },
    },
    {
        provider = 'vi_mode',
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold',
            }
        end,
    },
    {
        provider = 'file_info',
        hl = {
            fg = 'black',
            bg = 'darkgreen',
            style = 'bold',
        },
        left_sep = {
            'slant_left_2',
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
        },
        right_sep = {
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
            'slant_right_2',
            ' ',
        },
    },
    {
        provider = 'file_size',
        hl = {
            fg = 'green',
        },
        right_sep = {
            ' ',
        }
    },
    {
        provider = 'position',
        hl = {
            fg = 'black',
            bg = 'darkgreen',
            style = 'bold',
        },
        left_sep = {
            'slant_left_2',
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
        },
        right_sep = {
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
            'slant_right_2',
            ' ',
        }
    },
    {
        provider = 'diagnostic_errors',
        hl = { fg = 'red' },
    },
    {
        provider = 'diagnostic_warnings',
        hl = { fg = 'yellow' },
    },
    {
        provider = 'diagnostic_hints',
        hl = { fg = 'cyan' },
    },
    {
        provider = 'diagnostic_info',
        hl = { fg = 'green' },
    },
}

M.active[2] = {
    {
        provider = 'git_branch',
        hl = {
            fg = 'green',
            bg = 'black',
            style = 'bold',
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'black',
            },
        },
    },
    {
        provider = 'git_diff_added',
        hl = {
            fg = 'green',
            bg = 'black',
        },
    },
    {
        provider = 'git_diff_changed',
        hl = {
            fg = 'orange',
            bg = 'black',
        },
    },
    {
        provider = 'git_diff_removed',
        hl = {
            fg = 'red',
            bg = 'black',
        },
        right_sep = {
            str = ' ',
            hl = {
                fg = 'NONE',
                bg = 'black',
            },
        },
    },
    {
        provider = 'line_percentage',
        hl = {
            style = 'bold',
            fg = 'green',
        },
        left_sep = '  ',
        right_sep = ' ',
    },
    {
        provider = 'scroll_bar',
        hl = {
            fg = 'green',
            style = 'bold',
        },
    },
}

M.inactive[1] = {
    {
        provider = 'file_info',
        hl = {
            fg = 'black',
            bg = 'darkgreen',
            style = 'bold',
        },
        left_sep = {
            'slant_left_2',
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
        },
        right_sep = {
            { str = ' ', hl = { bg = 'darkgreen', fg = 'NONE' } },
            'slant_right_2',
            ' ',
        },
    },
    -- Empty component to fix the highlight till the end of the statusline
    {},
}

require('feline').setup({
    components = M
})
