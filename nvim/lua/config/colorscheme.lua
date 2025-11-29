return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavor = "macchiato",
      transparent_background = true,
      no_italic = true,
      no_bold = true,
      no_underline = true,
      styles = {},
      auto_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
    vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", {
      bg = "#45475a",
      fg = "#cdd6f4",
    })

    vim.api.nvim_set_hl(0, "@markup.raw.block", {
      bg = "#45475a",
      fg = "#cdd6f4",
    })
  end,
}
