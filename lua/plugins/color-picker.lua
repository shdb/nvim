return {
    "uga-rosa/ccc.nvim",
    cmd = "CccPick",
    event = "BufReadPost", -- Lazy load when opening a file
    keys = {
        { "<leader>cp", "<cmd>CccPick<CR>", desc = "Color Picker" },
        { "<leader>ct", "<cmd>CccHighlighterToggle<CR>", desc = "Toggle Color Highlight" },
        { "<leader>cv", "<cmd>CccConvert<CR>", desc = "Convert Color Format" },
    },
    config = function()
        local ccc = require("ccc")
        ccc.setup({
            inputs = {
                ccc.input.rgb,
                ccc.input.hsl,
                ccc.input.cmyk,
            },
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        })
    end,
}
