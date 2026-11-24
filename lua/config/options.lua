local opt = vim.opt

-- nvim-tree replaces netrw (the built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation (your 2-space default; Python's ftplugin still uses 4)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- Line numbers and gutter
opt.number = true
opt.relativenumber = false -- set true to make counts like 5j easier to read
opt.signcolumn = "yes" -- keeps text from jumping when diagnostics appear
opt.cursorline = true

-- Search
opt.ignorecase = true -- /foo matches Foo...
opt.smartcase = true -- ...unless you type a capital: /Foo matches only Foo
opt.hlsearch = true -- <Esc> in normal mode clears the highlight
opt.incsearch = true

-- Splits open where you'd expect
opt.splitright = true
opt.splitbelow = true

-- Files
opt.undofile = true -- undo history survives closing the file
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.fileencoding = "utf-8"

-- Display
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.showmode = false
opt.pumheight = 10
opt.updatetime = 300
opt.timeoutlen = 500 -- how long to wait for the next key in a sequence (which-key shows after this)
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect", "popup" }
opt.shortmess:append("c")

-- Window bar: file name, or a loud [TERMINAL] tag so it's obvious :w won't work there
opt.winbar =
  "%#WinBar# %{&buftype == 'terminal' ? ' [TERMINAL] ' : (expand('%:t') != '' ? ' + ' . expand('%:t') : ' [Empty Buffer]')} "

-- Homebrew on Apple Silicon (only added once, only on macOS)
if vim.fn.has("mac") == 1 and not vim.env.PATH:find("/opt/homebrew/bin", 1, true) then
  vim.env.PATH = vim.env.PATH .. ":/opt/homebrew/bin"
end

-- Neovide GUI
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.8
end
