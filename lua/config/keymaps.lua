-- General keymaps. Plugin keymaps live next to their plugin in lua/plugins/,
-- LSP keymaps in lua/plugins/lsp.lua.
local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Window navigation (also works from inside a terminal)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Window left" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Window down" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Window up" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Window right" })

-- Resize windows with Ctrl + arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Taller" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Shorter" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Narrower" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Wider" })

-- Splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontally" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close this split" })

-- Buffers (Neovim 0.11+ also has [b and ]b built in)
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- Save / quit
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })

-- Keep the cursor centered when scrolling and searching
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous match (centered)" })

-- Visual mode: move selected lines, keep selection when indenting
map("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("x", "<A-j>", ":move '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("x", "<A-k>", ":move '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })
map("x", "<", "<gv", { desc = "Indent left (keep selection)" })
map("x", ">", ">gv", { desc = "Indent right (keep selection)" })

-- Paste over a selection without losing what you copied
map("x", "p", '"_dP', { desc = "Paste without yanking" })

-- Don't fall into Ex mode by accident
map("n", "Q", "<nop>")

-- Terminal
map("n", "<leader>tt", "<cmd>botright 12split | terminal<CR>", { desc = "Terminal (bottom)" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal (side)" })
-- Double Esc leaves terminal mode. A single Esc still reaches programs
-- running in the terminal (nested nvim, ssh, etc.). <C-\><C-n> also works.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
