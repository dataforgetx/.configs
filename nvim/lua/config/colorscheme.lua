return {
  -- "bluz71/vim-nightfly-colors",
  -- name = "nightfly",
  -- priority = 1000,
  -- config = function()
  --   vim.g.nightflyItalics = false
  --   vim.g.nightflyTransparent = true
  --   vim.cmd("colorscheme nightfly")
  -- end,

  "nkxxll/ghostty-default-style-dark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("ghostty-default-style-dark").setup({
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
      dim_inactive = true,
    })
    vim.cmd.colorscheme("ghostty-default-style-dark")
  end,
}
