--
vim.cmd("set t_8f=^[[38;2;%lu;%lu;%lum") -- set foreground color
vim.cmd("set t_8b=^[[48;2;%lu;%lu;%lum") -- set background color

-- lang replacement per file
vim.cmd("autocmd BufRead,BufNewFile *.json set filetype=jsonc")

-- syntax
vim.cmd("syntax on")

-- theme
-- vim.cmd("colorscheme codedark")
vim.cmd("set mouse=")
