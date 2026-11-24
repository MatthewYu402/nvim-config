-- Entry point. Order matters:
--   1. leader keys + options (must exist before plugins load)
--   2. plugins (lazy.nvim reads lua/plugins/*.lua)
--   3. your keymaps and autocommands
--
-- Requires Neovim 0.11 or newer (0.12 recommended). Check with :version

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
