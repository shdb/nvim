return {
    "hamidi-dev/org-list.nvim",
    ft = { 'org' },
    dependencies = {
        "tpope/vim-repeat",  -- for repeatable actions with '.'
    },
    config = function()
        require("org-list").setup({
            mapping = {
                key = "<leader>olt",
                desc = "org cycle list types"
            },
            checkbox_toggle = {
                enabled = false,
                -- NOTE: for nvim-orgmode users, you should change the following mapping OR change the one from orgmode.
                -- If both mapping stay the same, the one from nvim-orgmode will "win"
                key = "<C-Space>",
                desc = "Toggle checkbox state",
                filetypes = { "org", "markdown" }     -- Add more filetypes as needed
            }
        })
    end
}
