return {
    'neovim/nvim-lspconfig',
    ft = { 'lua', 'rust', 'perl', 'typst' },
    opts = {
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        check = {
                            command = 'clippy',
                        },
                    },
                },
            },
            perlls = {
                settings = {},
            },
            tinymist = {
                settings = {
                    formatterMode = "typstyle",
                    exportPdf = "onType",
                    semanticTokens = "disable"
                },
            },
        },
    },
    config = function(_, opts)
        for name, conf in pairs(opts.servers) do
            vim.lsp.config(name, conf.settings)
            vim.lsp.enable(name)
        end

        vim.diagnostic.config({ virtual_lines = true })
    end
}
