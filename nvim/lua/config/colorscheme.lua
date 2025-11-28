return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        functions = {},
        variables = {},
      },
      dim_inactive = false,
      on_highlights = function(hl, c)
        hl["@function"] = { fg = c.blue }
        hl["@function.call"] = { fg = c.blue }
        hl.Function = { fg = c.blue }
      end,
    })
    vim.cmd("colorscheme tokyonight-moon")
  end,
}
