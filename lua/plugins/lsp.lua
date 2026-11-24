-- Language servers: Mason installs them, mason-lspconfig turns them on,
-- nvim-lspconfig supplies default settings, Neovim's built-in LSP client does the rest.
-- Completion uses Neovim's built-in popup (no nvim-cmp).
--
-- Servers below install on first start. pyright and ts_ls need Node/npm.
-- Java: add "jdtls" to the list (needs Java 21+ installed).
-- Open :Mason to see/install/remove servers by hand.

local servers = { "clangd", "pyright", "ts_ls", "lua_ls" }

local function setup_lsp()
  -- Diagnostics display (Neovim 0.11 turned inline messages off by default)
  vim.diagnostic.config({
    virtual_text = { spacing = 2, prefix = "●" },
    severity_sort = true,
    float = { border = "rounded", source = true },
    signs = true,
    underline = true,
  })

  -- Per-server tweaks, merged on top of nvim-lspconfig's defaults
  vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--header-insertion=never", "--completion-style=detailed" },
  })
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
        telemetry = { enable = false },
      },
    },
  })

  -- Completion popup keys (insert mode)
  local function pum(key, fallback)
    return function()
      return vim.fn.pumvisible() == 1 and key or fallback
    end
  end
  local expr = { expr = true, replace_keycodes = true }
  vim.keymap.set("i", "<Tab>", pum("<C-n>", "<Tab>"), expr)
  vim.keymap.set("i", "<S-Tab>", pum("<C-p>", "<S-Tab>"), expr)
  vim.keymap.set("i", "<C-j>", pum("<C-n>", "<C-j>"), expr)
  vim.keymap.set("i", "<C-k>", pum("<C-p>", "<C-k>"), expr)
  -- <C-y> accepts the highlighted item, <C-e> closes the popup (both built in).
  -- Enter is left to nvim-autopairs so {<Enter>} still expands nicely.

  -- Keymaps that only exist in buffers with a language server attached
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
      end

      -- Neovim already provides: K hover, grn rename, gra code action,
      -- grr references, gri implementation, gO symbols, [d ]d diagnostics,
      -- <C-s> signature help (insert mode). These add easier-to-remember names:
      map("n", "gd", vim.lsp.buf.definition, "Go to definition")
      map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
      map("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
      map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
      map("n", "<F4>", vim.lsp.buf.code_action, "Code action")
      map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostic")
      map("n", "<leader>cf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format file")
      map("n", "<leader>ch", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
      end, "Toggle inlay hints")

      -- Auto-popup completion as you type (letters + the server's own trigger characters)
      if client and client:supports_method("textDocument/completion") then
        local provider = client.server_capabilities.completionProvider
        if provider then
          local chars, seen = {}, {}
          for _, c in ipairs(provider.triggerCharacters or {}) do
            seen[c] = true
            table.insert(chars, c)
          end
          for c in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):gmatch(".") do
            if not seen[c] then
              table.insert(chars, c)
            end
          end
          provider.triggerCharacters = chars
        end
        vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      end
    end,
  })
end

return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      setup_lsp()
      -- mason itself is already set up (it's a dependency, so lazy loads it first)
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })
    end,
  },
}
