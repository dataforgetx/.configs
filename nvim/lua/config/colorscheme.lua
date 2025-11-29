return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("tokyonight")
  end,
}
