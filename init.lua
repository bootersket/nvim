-- Quality of life stuff
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true



-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("lazy.nvim not found! Run the install command.")
    return
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "numToStr/Comment.nvim", config = true },
    -- Color schemes
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "folke/tokyonight.nvim", priority = 1000 },
    { "EdenEast/nightfox.nvim", priority = 1000 },
    { "windwp/nvim-autopairs", config = true },
})

vim.opt.termguicolors = true
-- Cool color schemes:
vim.cmd("colorscheme carbonfox")
vim.cmd [[
    highlight Comment guifg=#00ff00 ctermfg=244

]]

