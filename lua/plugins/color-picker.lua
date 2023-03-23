local function getconfig()
    require("color-picker").setup({ -- for changing icons & mappings
        -- ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "ﱢ", "" },
        -- ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        -- ["keymap"] = { -- mapping example:
        --	["U"] = "<Plug>ColorPickerSlider5Decrease",
        --	["O"] = "<Plug>ColorPickerSlider5Increase",
        --},
    })

    vim.keymap.set('n', '<leader>cp', ':PickColor<cr>')
    vim.keymap.set('i', '<leader>cp', ':PickColorInsert<cr>')
end

return {
    'ziontee113/color-picker.nvim',
    config = function()
        getconfig()
    end
}
