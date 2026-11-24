return {
  -- Auto-close brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Treesitter: better highlighting and indentation.
  -- The `main` branch works differently from the old `master` branch:
  -- there is no ensure_installed/highlight option; you install parsers
  -- and start highlighting yourself (done below).
  -- Building parsers needs a C compiler and the tree-sitter CLI
  -- (`brew install tree-sitter-cli`, or :MasonInstall tree-sitter-cli).
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "c", "cpp", "java", "python", "javascript", "typescript",
        "lua", "vim", "vimdoc", "markdown", "markdown_inline", "query", "bash", "json",
      }
      local ok, ts = pcall(require, "nvim-treesitter")
      if ok and vim.fn.executable("tree-sitter") == 1 then
        ts.install(parsers)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(ev)
          -- Highlighting: silently skipped when there's no parser for this filetype
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
