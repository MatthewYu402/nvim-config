return {
  -- Color scheme (yours)
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup()
      vim.cmd.colorscheme("github_dark")
    end,
  },

  -- Animated cursor (off in Neovide, which has its own)
  {
    "sphamba/smear-cursor.nvim",
    lazy = false,
    enabled = not vim.g.neovide,
    opts = {
      stiffness = 0.5,
      trailing_stiffness = 0.1,
      trailing_exponent = 0,
      distance_stop_animating = 0.3,
    },
  },

  -- Icons (needs a Nerd Font in your terminal to look right)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Shows available keys after you press Space (or g, z, [, ], ") and wait
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>s", group = "split" },
        { "<leader>t", group = "terminal" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Keymaps for this buffer",
      },
    },
  },
}
