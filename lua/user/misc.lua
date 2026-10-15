-- remove trailing whitespaces on save
vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*',
    callback = function(env)
        -- Exclude filetypes that can have trailing whitespaces
        local filetype_blacklist = {
            ['markdown']        = true,
            ['diff']            = true,
            ['gitcommit']       = true,
            ['mail']            = true,
            ['help']            = true,
            ['TelescopePrompt'] = true,
            ['lazy']            = true,
            ['mason']           = true,
        }
        if filetype_blacklist[vim.bo.filetype] then
            return
        end

        -- Exclude non-file buffers (like terminal, prompt, quickfix, nofile)
        local buftype_blacklist = {
            ['terminal'] = true,
            ['nofile']   = true,
            ['prompt']   = true,
            ['quickfix'] = true,
        }
        if buftype_blacklist[vim.bo.buftype] then
            return
        end

        -- Save cursor position and window view state
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local view = vim.fn.winsaveview()

        vim.cmd('%s/\\s\\+$//e')

        -- Restore cursor position and view state
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.fn.winrestview(view)
    end
})

-- only show the CursorLine for the active window
local cl_var = "auto_cursorline"

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  group = vim.api.nvim_create_augroup("enable_auto_cursorline", { clear = true }),
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, cl_var)
    if ok and cl then
      vim.api.nvim_win_del_var(0, cl_var)
      vim.o.cursorline = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  group = vim.api.nvim_create_augroup("disable_auto_cursorline", { clear = true }),
  callback = function()
    local cl = vim.o.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, cl_var, cl)
      vim.o.cursorline = false
    end
  end,
})
