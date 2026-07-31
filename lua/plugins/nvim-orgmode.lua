return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        -- Setup orgmode
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',
            win_split_mode = float,
            org_hide_emphasis_markers = true,
            org_blank_before_new_entry = { heading = false, plain_list_item = false },
        })

        -- Experimental LSP support
        vim.lsp.enable('org')
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "org",
            callback = function()
                vim.opt_local.conceallevel = 3
            end,
        })
    end,
}
