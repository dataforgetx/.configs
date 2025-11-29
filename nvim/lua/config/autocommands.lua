-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- preview markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreview", { buffer = true, desc = "Markdown Preview" })
    vim.keymap.set("n", "<leader>ms", "<Plug>MarkdownPreviewStop", { buffer = true, desc = "Stop Markdown Preview" })
    vim.keymap.set(
      "n",
      "<leader>mt",
      "<Plug>MarkdownPreviewToggle",
      { buffer = true, desc = "Toggle Markdown Preview" }
    )
  end,
})
