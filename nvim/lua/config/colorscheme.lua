return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      float = {
        transparent = true, -- enable transparent floating windows
        solid = true, -- use solid styling for floating windows, see |winborder|
      },
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = true, -- Force no italic
      no_bold = true, -- Force no bold
      no_underline = true, -- Force no underline
      styles = {},
      default_integrations = true,
      auto_integrations = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")

    -- markdown code block background
    vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", {
      bg = "#45475a", -- Catppuccin mocha surface0
      fg = "#cdd6f4", -- Catppuccin mocha text
    })
    vim.api.nvim_set_hl(0, "@markup.raw.block", {
      bg = "#45475a",
      fg = "#cdd6f4",
    })
  end,
}
