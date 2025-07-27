local function getconfig()
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local colors = {
        bright_bg  = '#ff8700',
        bright_fg  = 'darkgreen',
        red        = 'darkgreen',
        dark_red   = 'darkgreen',
        green      = 'darkgreen',
        blue       = 'darkgreen',
        gray       = 'darkgreen',
        orange     = 'darkgreen',
        purple     = 'darkgreen',
        cyan       = 'darkgreen',
        diag_warn  = 'darkgreen',
        diag_error = 'darkgreen',
        diag_hint  = 'darkgreen',
        diag_info  = 'darkgreen',
        git_del    = 'darkgreen',
        git_add    = 'darkgreen',
        git_change = 'darkgreen',
    }

    require("heirline").load_colors(colors)

    local Align = { provider = "%=" }
    local Space = { provider = " " }

    local ViMode = {
        -- get vim current mode, this information will be required by the provider
        -- and the highlight functions, so we compute it only once per component
        -- evaluation and store it as a component attribute
        init = function(self)
            self.mode = vim.fn.mode(1) -- :h mode()
        end,
        -- Now we define some dictionaries to map the output of mode() to the
        -- corresponding string and color. We can put these into `static` to compute
        -- them at initialisation time.
        static = {
            mode_names = { -- change the strings if you like it vvvvverbose!
                n = "N",
                no = "N?",
                nov = "N?",
                noV = "N?",
                ["no\22"] = "N?",
                niI = "Ni",
                niR = "Nr",
                niV = "Nv",
                nt = "Nt",
                v = "V",
                vs = "Vs",
                V = "V_",
                Vs = "Vs",
                ["\22"] = "^V",
                ["\22s"] = "^V",
                s = "S",
                S = "S_",
                ["\19"] = "^S",
                i = "I",
                ic = "Ic",
                ix = "Ix",
                R = "R",
                Rc = "Rc",
                Rx = "Rx",
                Rv = "Rv",
                Rvc = "Rv",
                Rvx = "Rv",
                c = "C",
                cv = "Ex",
                r = "...",
                rm = "M",
                ["r?"] = "?",
                ["!"] = "!",
                t = "T",
            },
            mode_colors = {
                n = "green" ,
                i = "red",
                v = "cyan",
                V =  "cyan",
                ["\22"] =  "cyan",
                c =  "orange",
                s =  "purple",
                S =  "purple",
                ["\19"] =  "purple",
                R =  "orange",
                r =  "orange",
                ["!"] =  "red",
                t =  "red",
            }
        },
        -- We can now access the value of mode() that, by now, would have been
        -- computed by `init()` and use it to index our strings dictionary.
        -- note how `static` fields become just regular attributes once the
        -- component is instantiated.
        -- To be extra meticulous, we can also add some vim statusline syntax to
        -- control the padding and make sure our string is always at least 2
        -- characters long. Plus a nice Icon.
        provider = function(self)
            --return " %2("..self.mode_names[self.mode].."%)"
            return " %2("..self.mode_names[self.mode].."%)"
        end,
        -- Same goes for the highlight. Now the foreground will change according to the current mode.
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = self.mode_colors[mode], bold = true, }
        end,
        -- Re-evaluate the component only on ModeChanged event!
        -- Also allows the statusline to be re-evaluated when entering operator-pending mode
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function()
                vim.cmd("redrawstatus")
            end),
        },
    }

    local FileNameBlock = {
        -- let's first set up some attributes needed by this component and its children
        init = function(self)
            self.filename = vim.api.nvim_buf_get_name(0)
        end,
    }
    -- We can now define some children separately and add them later

    local FileIcon = {
        init = function(self)
            local filename = self.filename
            local extension = vim.fn.fnamemodify(filename, ":e")
            self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
            return self.icon and (self.icon .. " ")
        end,
        hl = { fg = 'black' }
    }

    local FileName = {
        provider = function(self)
            -- first, trim the pattern relative to the current directory. For other
            -- options, see :h filename-modifers
            local filename = vim.fn.fnamemodify(self.filename, ":.")
            if filename == "" then return "[No Name]" end
            -- now, if the filename would occupy more than 1/4th of the available
            -- space, we trim the file path to its initials
            -- See Flexible Components section below for dynamic truncation
            if not conditions.width_percent_below(#filename, 0.25) then
                filename = vim.fn.pathshorten(filename)
            end
            return filename
        end,
        hl = { fg = 'black', bold = true },
    }

    local FileFlags = {
        {
            condition = function()
                return vim.bo.modified
            end,
            provider = " ● ",

            hl = { fg = "black" },
        },
        {
            condition = function()
                return not vim.bo.modifiable or vim.bo.readonly
            end,
            provider = "  ",
            hl = { fg = "black" },
        },
    }

    -- Now, let's say that we want the filename color to change if the buffer is
    -- modified. Of course, we could do that directly using the FileName.hl field,
    -- but we'll see how easy it is to alter existing components using a "modifier"
    -- component

    local FileNameModifer = {
        hl = function()
            if vim.bo.modified then
                -- use `force` because we need to override the child's hl foreground
                return { fg = "black", bold = true, force=true }
            end
        end,
    }

    -- let's add the children to our FileNameBlock component
    FileNameBlock = utils.insert(FileNameBlock,
        FileIcon,
        utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
        FileFlags,
        { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
    )

    FileNameBlock = utils.surround({ '', '' }, 'darkgreen', { FileNameBlock })

    local Git = {
        condition = conditions.is_git_repo,

        init = function(self)
            self.status_dict = vim.b.gitsigns_status_dict
            self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
        end,

        hl = { fg = "green" },


        {   -- git branch name
            provider = function(self)
                return " " .. self.status_dict.head
            end,
            hl = { bold = true }
        },
        -- You could handle delimiters, icons and counts similar to Diagnostics
        {
            condition = function(self)
                return self.has_changes
            end,
            provider = " "
        },
        {
            provider = function(self)
                local count = self.status_dict.added or 0
                return count > 0 and ("" .. count)
            end,
            hl = { fg = 'darkgreen' },
        },
        {
            provider = function(self)
                local count = self.status_dict.removed or 0
                return count > 0 and ("" .. count)
            end,
            hl = { fg = 'darkgreen' },
        },
        {
            provider = function(self)
                local count = self.status_dict.changed or 0
                return count > 0 and ("" .. count)
            end,
            hl = { fg = 'darkgreen' },
        },
        {
            condition = function(self)
                return self.has_changes
            end,
            provider = " ",
        },
    }

    local LSPActive = {
        condition = conditions.lsp_attached,
        update = {'LspAttach', 'LspDetach'},

        -- You can keep it simple,
        -- provider = " [LSP]",

        -- Or complicate things a bit and get the servers names
        utils.surround({ '', '' }, 'darkgreen', {
            provider = function()
                local names = {}
                for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    table.insert(names, server.name)
                end
                return " " .. table.concat(names, " ")
            end,
        }),
        hl = { fg = "black", bold = true },
    }

    local Diagnostics = {

        condition = conditions.has_diagnostics,

        init = function(self)
            self.error_icon = ''
            self.warn_icon  = ''
            self.info_icon  = '󰋇'
            self.hint_icon  = '󰌵'

            self.errors     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
            self.warnings   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
            self.hints      = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
            self.info       = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,

        update = { "DiagnosticChanged", "BufEnter" },

        {
            --provider = "![",
        },
        {
            provider = function(self)
                -- 0 is just another output, we can decide to print it or not!
                return self.errors > 0 and (self.error_icon .. self.errors .. " ")
            end,
            hl = { fg = "diag_error" },
        },
        {
            provider = function(self)
                return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
            end,
            hl = { fg = "diag_warn" },
        },
        {
            provider = function(self)
                return self.info > 0 and (self.info_icon .. self.info .. " ")
            end,
            hl = { fg = "diag_info" },
        },
        {
            provider = function(self)
                return self.hints > 0 and (self.hint_icon .. self.hints)
            end,
            hl = { fg = "diag_hint" },
        },
        {
            --provider = "]",
        },
    }

    local FileType = {
        provider = function()
            return string.upper(vim.bo.filetype)
        end,
        hl = { fg = '#cecb00', bold = true },
    }

    local FileEncoding = {
        condition = function()
            local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
            return enc ~= 'utf-8'
        end,
        provider = function()
            local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
            --return enc ~= 'utf-8' and enc:upper() .. ' '
            return enc:upper() .. ' '
        end
    }

    local FileFormat = {
        condition = function()
            local fmt = vim.bo.fileformat
            return fmt ~= 'unix'

        end,
        provider = function()
            local fmt = vim.bo.fileformat
            return fmt:upper() .. ' '
        end
    }

    local Ruler = {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %P = percentage through file of displayed window
        provider = "%l/%L%:%c┃%P",
        hl = { fg = 'black', bold = true }
    }
    Ruler = utils.surround({ '', '' }, 'darkgreen', { Ruler })

    local ScrollBar ={
        static = {
            sbar = { '▇', '▆', '▅', '▄', '▃', '▂', '▁', }
            -- Another variant, because the more choice the better.
            -- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
        },
        provider = function(self)
            local curr_line = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
            return string.rep(self.sbar[i], 2)
        end,
        hl = { fg = '#111111', bg = 'darkgreen' },
    }

    return {
        opts = {
            colors = {
                StatusLine = '#00ff00',
                StatusLineNC = '#005f00',
                --diag_error = utils.get_highlight('DiagnosticError').fg,
                --diag_warn = utils.get_highlight('DiagnosticWarn').fg,
                --diag_info = utils.get_highlight('DiagnosticInfo').fg,
                --diag_hint = utils.get_highlight('DiagnosticHint').fg,
            },
        },
        statusline = {
            hl = function()
                if conditions.is_active() then
                    return 'StatusLine'
                end
                return '#005f00'
            end,
            ViMode, Space,
            FileNameBlock, Space,
            Git, Align,
            Diagnostics,
            LSPActive, Space,
            FileType, Space,
            FileFormat, FileEncoding,
            Ruler, Space, ScrollBar,
        }
    }
end


return {
    'rebelot/heirline.nvim',
    --opts = getconfig()
    opts = function()
        require("heirline").setup(
            getconfig()
        )
    end
}
