-- make ncat happy
local vimregex = false
if vim.v.argv[5] and vim.v.argv[5]:match('NoMatchParen') then
    vimregex = true
end

local function getconfig()
    require('nvim-treesitter.configs').setup {
      -- A list of parser names, or "all"
        ensure_installed = {
            'bash',
            'c',
            'cpp',
            'go',
            --'help',
            'html',
            'javascript',
            'json',
            --'latex',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'perl',
            'python',
            'query',
            'regex',
            'ruby',
            'rust',
            'tsx',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        },
        sync_install = false,      -- Install parsers synchronously (only applied to `ensure_installed`)
        ignore_install = { "" },   -- List of parsers to ignore installing (for "all")

        highlight = {
            enable = true,         -- `false` will disable the whole extension

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            disable = { "" },

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = vimregex,
        },
    }
end

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    config = function()
        getconfig()
    end
}
