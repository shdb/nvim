vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*',
    callback = function(env)
        if vim.bo.filetype == 'markdown' then  -- markdown files can have trailing whitespaces
            return
        end
        vim.cmd('%s/\\s\\+$//e')  -- remove trailing whitespaces on save
    end
})
