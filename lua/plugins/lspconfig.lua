return {
    'neovim/nvim-lspconfig',
    ft = { 'lua', 'rust', 'perl' },
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
        },
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig');

        for name, conf in pairs(opts.servers) do
            lspconfig[name].setup {
                settings = conf.settings,
            }
        end
    end
}
