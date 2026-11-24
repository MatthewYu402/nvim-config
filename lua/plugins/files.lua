return {
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- so `nvim some/folder` opens the tree
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>o", "<cmd>NvimTreeFindFile<CR>", desc = "Show current file in tree" },
    },
    opts = {
      view = { width = 32 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Search text in project" },
      { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Open buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in this file" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Symbols in file" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help topics" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "All keymaps" },
      { "<leader><leader>", "<cmd>Telescope buffers<CR>", desc = "Switch buffer" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "%.git[/\\]", "node_modules[/\\]", "%.o$", "%.obj$", "%.exe$", "%.class$" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
    end,
  },
}
