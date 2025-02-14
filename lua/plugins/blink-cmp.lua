return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    --event = {'LspAttach'},

    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            ["<Esc>"] = { "cancel", "fallback" },
            ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            --["<CR>"] = { "accept", "fallback" },
            ["<CR>"] = {
                function(cmp)
                    local mode = vim.api.nvim_get_mode().mode
                    if mode == 'c' then
                        return nil
                    end

                    local selected_item = require('blink.cmp.completion.list').get_selected_item()
                    if cmp.is_visible then
                        if selected_item ~= nil then
                            return cmp.accept()
                        else
                            return cmp.accept({ index = 1 })
                        end
                    end
                end,
                "fallback"
            },

            ["<Tab>"] = {
                function(cmp)
                    return cmp.select_next()
                end,
                "snippet_forward",
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    return cmp.select_prev()
                end,
                "snippet_backward",
                "fallback",
            },

            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-up>"] = { "scroll_documentation_up", "fallback" },
            ["<C-down>"] = { "scroll_documentation_down", "fallback" },
        },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- Will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        completion = {
            documentation = {
                -- auto_show = true,
                -- auto_show_delay_ms = 250,
                treesitter_highlighting = true,
                window = { border = 'rounded' },
            },
            menu = {
                border = 'rounded',

                -- Don't show completion menu automatically when searching
                auto_show = function(ctx)
                    return ctx.mode ~= "cmdline" or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
                end,
            },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },

            -- don't show the popup for short commands
            --min_keyword_length = function(ctx)
            --    -- only applies when typing a command, doesn't apply to arguments
            --    if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
            --    return 0
            --end,
        },
    },
    opts_extend = { 'sources.default' }
}
