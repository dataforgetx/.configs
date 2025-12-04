return {
  "ggandor/leap.nvim",
  enabled = true,
  config = function()
    local leap = require("leap")

    -- set up your custom key mapping with <leader>f
    vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "leap forward" })
    vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "leap backward" })
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "leap between window splits" })

    -- customize the highlight color
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    vim.api.nvim_set_hl(0, "LeapMatch", {
      fg = "white",
      bold = true,
      nocombine = true,
    })
  end,
}
