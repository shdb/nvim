vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*',
    callback = function(env)
        if vim.bo.filetype == 'markdown' then  -- markdown files can have trailing whitespaces
            return
        end
        vim.cmd('%s/\\s\\+$//e')  -- remove trailing whitespaces on save
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
