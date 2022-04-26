vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = {'*'},
  command = ':%s/\\s\\+$//e',  -- remove trailing whitespace on save
})
