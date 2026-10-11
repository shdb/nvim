return {
    "xheisenbugx/org.nvim",
    main = "org",
    lazy = false, -- startup cost is small: heavy modules load on first use
    opts = {
        org_directory = "~/orgfiles/",
        agenda_files = { "~/orgfiles/**/*.org" },
        default_notes_file = "~/orgfiles/refile.org",
    },
    config = function()
        require("org").setup({
            extensions = {
                present = true, -- enable with the defaults
                roam = { directory = "~/orgfiles/roam" }, -- options are merged over its defaults
            },
            ui = {
                bullets = { "◉", "○", "✸", "✿" },      -- or false
                checkboxes = { " ", "◐", "✓" },        -- or false
                indent_mode = true,                   -- org-indent-mode
            },
        })
    end
}
