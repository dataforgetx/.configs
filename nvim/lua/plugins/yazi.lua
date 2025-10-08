return {
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  keys = {
    {
      "<leader>-",
      mode = { "n", "v" },
      "<cmd>Yazi<CR>",
      desc = "Open Yazi at the current file",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<CR>",
      desc = "Open Yazi in nvim's working directory",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
