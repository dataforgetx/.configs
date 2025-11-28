return {
  "stevearc/oil.nvim",
  lazy = false,
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
      },
      float = {
        padding = 4,
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.5),
        border = "rounded",
      },
      win_options = {
        winhighlight = "Normal:Normal,NormalFloat:Normal,FloatBorder:Normal",
      },
    })
    vim.api.nvim_set_hl(0, "OilDir", { fg = "#c5c8c6" })
  end,
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
  },
}
