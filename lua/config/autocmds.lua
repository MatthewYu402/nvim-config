local group = vim.api.nvim_create_augroup("user_config", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Briefly highlight whatever you yank
autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- Don't continue comments onto the next line with o / O / Enter
autocmd("FileType", {
  group = group,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Starting nvim with no file opens in ~/Documents
autocmd("VimEnter", {
  group = group,
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.isdirectory(vim.fn.expand("~/Documents")) == 1 then
      vim.cmd.cd("~/Documents")
    end
  end,
})

-- Safety net from your old config, narrowed: only unlocks a buffer when it is a
-- real file on disk. Plugin windows (Telescope, Mason, LSP popups, lazy) have
-- no file behind them, so they are left alone.
autocmd("BufEnter", {
  group = group,
  callback = function(ev)
    local bt = vim.bo[ev.buf].buftype
    if bt ~= "nofile" and bt ~= "nowrite" then
      return
    end
    local name = vim.api.nvim_buf_get_name(ev.buf)
    if name ~= "" and vim.fn.filereadable(name) == 1 and not vim.bo[ev.buf].filetype:lower():match("tree") then
      vim.bo[ev.buf].buftype = ""
      vim.bo[ev.buf].modifiable = true
    end
  end,
})

-- Winbar colors. Set on ColorScheme because loading a colorscheme wipes
-- custom highlights (that's why the old config's colors may not have shown).
local function winbar_hl()
  vim.api.nvim_set_hl(0, "WinBar", { bg = "#388bfd", fg = "#0d1117", bold = true })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "#30363d", fg = "#c9d1d9" })
end
autocmd("ColorScheme", { group = group, callback = winbar_hl })
winbar_hl()
