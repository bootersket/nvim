-- Quality of life stuff
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false





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
    {
      "iamcco/markdown-preview.nvim",
      build = "cd app & npm install",
      ft = { "markdown" },
      config = function()
        vim.g.mkdp_auto_start = 0
      end,
    },
})

vim.opt.termguicolors = true

-- Select color scheme to use
vim.cmd("colorscheme carbonfox")

-- Make all comments green
vim.cmd [[
    highlight Comment guifg=#00ff00 ctermfg=244

]]

-- When typing a comment line don't make next line a comment
-- (only works when hitting o, not when hitting enter. TODO?)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "o", "r "})
  end,
})

-- Remember where cursor was when closing a file so
-- it opens to the same spot
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern= "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.cmd("normal! zz") -- center screen
    end
  end,
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.vert", "*.frag"},
  callback = function() vim.bo.filetype = "glsl" end
})


-- TODO: THIS DOESN'T WORK!!
-- For some reason .js file doesn't respect the tabstop/shiftwidth settings I defined above
-- todo: use a variable or something for these values so it always matches the above ones?
vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})


-- Multiple editors workflow:
-- WINDOWS:
-- :split filename or <C-w>s
-- :vsplit filename or <C-w>v
--    Navigate:
--    Direction: <C-w><h/j/k/l>
--    Cycle: <C-w><w>
-- TABS:
-- :tabnew filename  or  :tabedit filename
-- Switch tabs:
--   :tabnext  :tabn  gt
--   :tabprev  :tabp  gT
