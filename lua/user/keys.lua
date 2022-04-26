vim.keymap.set('t', '<a-h>', '<c-\\><c-n><c-w>h')  -- jump a window to the right
vim.keymap.set('t', '<a-j>', '<c-\\><c-n><c-w>j')  -- jump a window down
vim.keymap.set('t', '<a-k>', '<c-\\><c-n><c-w>k')  -- jump a window up
vim.keymap.set('t', '<a-l>', '<c-\\><c-n><c-w>l')  -- jump a window to the left
vim.keymap.set('n', '<a-h>', '<c-w>h')             -- jump a window to the right
vim.keymap.set('n', '<a-j>', '<c-w>j')             -- jump a window down
vim.keymap.set('n', '<a-k>', '<c-w>k')             -- jump a window up
vim.keymap.set('n', '<a-l>', '<c-w>l')             -- jump a window to the left
vim.keymap.set('n', '<s-l>', ':bnext<cr>')         -- go to the next buffer
vim.keymap.set('n', '<s-h>', ':bprevious<cr>')     -- go to the previous buffer

vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

vim.keymap.set('v', '.', ':normal .<CR>')          -- repeats the last command for the entire visual selection
