return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        -- theme = "nightfly",
        theme = "ghostty-default-style-dark",
        globalstatus = true, --single status line at bottom instead of per-window
      },
    })
  end,
  -- Make sure lualine loads after our color scheme
  dependencies = { "RRethy/base16-nvim", "nvim-tree/nvim-web-devicons" },
}
