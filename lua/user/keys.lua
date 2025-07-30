--vim.keymap.set('t', '<a-h>', '<c-\\><c-n><c-w>h')  -- jump a window to the right
--vim.keymap.set('t', '<a-j>', '<c-\\><c-n><c-w>j')  -- jump a window down
--vim.keymap.set('t', '<a-k>', '<c-\\><c-n><c-w>k')  -- jump a window up
--vim.keymap.set('t', '<a-l>', '<c-\\><c-n><c-w>l')  -- jump a window to the left
--vim.keymap.set('n', '<a-h>', '<c-w>h')             -- jump a window to the right
--vim.keymap.set('n', '<a-j>', '<c-w>j')             -- jump a window down
--vim.keymap.set('n', '<a-k>', '<c-w>k')             -- jump a window up
--vim.keymap.set('n', '<a-l>', '<c-w>l')             -- jump a window to the left
vim.keymap.set('n', '<s-l>', ':bnext<cr>')         -- go to the next buffer
vim.keymap.set('n', '<s-h>', ':bprevious<cr>')     -- go to the previous buffer

vim.keymap.set('v', '.', ':normal .<CR>')          -- repeats the last command for the entire visual selection

vim.keymap.set('n', '<M-.>', '<c-w>>')             -- increase horizontal window size
vim.keymap.set('n', '<M-,>', '<c-w><')             -- decrease horizontal window size
vim.keymap.set('n', '<M-t>', '<c-w>+')             -- increase vertical window size
vim.keymap.set('n', '<M-s>', '<c-w>-')             -- decrease vertical window size

local function toggle_diagnostics()
    local val = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({
        virtual_lines = val,
        underline     = val,
    })
end

vim.keymap.set('n', '<leader>ds', toggle_diagnostics, { desc = 'toggle diagnostics' })
