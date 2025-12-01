-- increment and decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

vim.keymap.set("n", "<CR>", ";", { desc = "forward search using f + search_term" })
vim.keymap.set("n", ";", ":w<CR>", { desc = "Save file without quitting" })
vim.keymap.set("n", "Z", ":wq<CR>", { desc = "Save and quit" })
vim.keymap.set("n", "Q", ":q!<CR>", { desc = "Quit without saving" })

-- exit command history panel (accidentally by typing q:)
-- hit <Esc> twice to exit and it will clear search highlights as well
vim.keymap.set("n", "<Esc>", function()
  if vim.fn.getcmdwintype() ~= "" then
    -- In command window, exit it
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", false)
  else
    -- In normal buffer, clear highlights
    vim.cmd("nohlsearch")
  end
end, { desc = "Clear highlights or exit command window", silent = true })

-- disable showkey when using undotree due to conflict
vim.keymap.set("n", "<leader>u", function()
  vim.cmd("UndotreeToggle")
end)

-- automatic marks remap
vim.keymap.set("n", "..", "`^", { desc = "jump to where you last left insert mode" })
vim.keymap.set("n", ".,", "`.", { desc = "jump to where you last changed or edited" })
vim.keymap.set("n", ".;", "`0", { desc = "jump to where you last exited vim" })
vim.keymap.set("n", "<C-.>", "<C-^>", { desc = "jump to alternate file" })

-- location & quickfix
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { silent = true, desc = "move to next in the quickfix list" })
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { silent = true, desc = "move to next in the quickfix list" })
vim.keymap.set("n", "<leader>cw", ":copen<CR>", { silent = true, desc = "open the quickfix list" })
vim.keymap.set("n", "<leader>cc", ":ccl<CR>", { silent = true, desc = "close the quickfix list" })

-- Delete to blackhole register
vim.keymap.set("n", "\\d", '"_d', { desc = "Delete to blackhole" })
vim.keymap.set("v", "\\d", '"_d', { desc = "Delete selection to blackhole" })
vim.keymap.set("n", "\\D", '"_D', { desc = "Delete to end of line to blackhole" })

-- Change to blackhole register
vim.keymap.set("n", "\\c", '"_c', { desc = "Change to blackhole" })
vim.keymap.set("v", "\\c", '"_c', { desc = "Change selection to blackhole" })
vim.keymap.set("n", "\\C", '"_C', { desc = "Change to end of line to blackhole" })

-- cd to the directory containing the file in the buffer, both local and global flavors
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file directory" })
vim.keymap.set("n", "<leader>lcd", ":lcd %:p:h<CR>:pwd<CR>", { desc = "cd to current file directory locally" })

-- Delete line to blackhole register
vim.keymap.set("n", "\\dd", '"_dd', { desc = "Delete line to blackhole" })

--  switch between current and prev buffers
vim.keymap.set("n", "<leader>bb", "<C-^>", { desc = "Switch between current and previous buffer" })

local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

-- <leader>bo to close all other buffers
vim.keymap.set("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })

-- toggle show keypress on screen
vim.keymap.set("n", "<leader>ts", ":ShowkeysToggle<CR>", { desc = "Toggle Showkeys", silent = true })
-- toggle a countdown timer on screen
vim.keymap.set("n", "<leader>tt", ":TimerlyToggle<CR>", { desc = "Toggle Timerly", silent = true })

-- Map x to delete to black hole register in normal and visual modes
vim.keymap.set("n", "x", '"_x', { noremap = true, desc = "Delete character (black hole register)" })
vim.keymap.set("v", "x", '"_x', { noremap = true, desc = "Delete selection (black hole register)" })

-- when joining lines, keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in place when jump half screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in place when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- search and replace word across multiple files using nvim-spectre
vim.keymap.set("n", "<leader>rp", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Replace word in project" })

vim.keymap.set("n", "<leader>rf", function()
  require("spectre").open_file_search({ select_word = true })
end, { desc = "Replace word in current file" })

-- Toggle nvim-spectre
vim.keymap.set("n", "<leader>ns", function()
  require("spectre").toggle()
end, { desc = "Toggle Spectre" })

-- go to parent directory in oil.nvim
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open oil in current file's directory" })

-- <leader>p to paste over a text (so that the original paste buffer won't be overwritten)
vim.keymap.set("x", "<leader>p", '"_dP')

-- replace text under cursor
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace text under cursor" }
)

--- various text objects
--- entire buffer: ae or gG
vim.keymap.set("o", "ae", ":<C-u>normal! ggVG<CR>", { desc = "Entire buffer", silent = true })
vim.keymap.set("o", "ae", ":<C-u>normal! ggVG<CR>", { desc = "Entire buffer", silent = true })
vim.keymap.set("x", "gG", ":<C-u>normal! ggVG<CR>", { desc = "Entire buffer", silent = true })
vim.keymap.set("x", "gG", ":<C-u>normal! ggVG<CR>", { desc = "Entire buffer", silent = true })

-- Remap keys for better Window management
vim.keymap.set("n", "<leader>vs", "<C-w>v", { desc = "Vertical Split", silent = true }) -- split window vertically
vim.keymap.set("n", "<leader>hs", "<C-w>s", { desc = "Horizontal Split", silent = true }) -- split window horizontally
vim.keymap.set("n", "<leader>es", "<C-w>=", { desc = "Equal Split", silent = true }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>as", "<C-w>o", { desc = "Keep the active window", silent = true })
vim.keymap.set("n", "<leader>cs", "<cmd>close<CR>", { desc = "Close Split", silent = true }) -- close current split window

-- Exit terminal mode in the '<cmd>Telescope terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreviewStop<cr>", { desc = "Markdown Preview Stop" })

-- resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- neogit
vim.keymap.set(
  "n",
  "<leader>gh",
  "<cmd>Neogit kind=split<CR>",
  { desc = "Enter Neogit with horizontal split", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>gs",
  "<cmd>Neogit kind=vsplit<CR>",
  { desc = "Enter Neogit with vertical split", silent = true }
)

-- diffview
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen<CR>", { desc = "Open Diff View", silent = true })
vim.keymap.set("n", "<leader>cd", "<cmd>DiffviewClose<CR>", { desc = "Close Diff View", silent = true })

-- debugging
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "continue debugging" })

vim.keymap.set("n", "<leader>dv", function()
  require("dap").step_over()
end, { desc = "step over" })

vim.keymap.set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "step into" })

vim.keymap.set("n", "<leader>du", function()
  require("dap").step_out()
end, { desc = "step out" })

vim.keymap.set("n", "<Leader>dg", function()
  require("dap").toggle_breakpoint()
end, { desc = "toggle breakpoint" })

vim.keymap.set("n", "<Leader>db", function()
  require("dap").set_breakpoint()
end, { desc = "set breakpoint" })

vim.keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end, { desc = "open repl" })

vim.keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end, { desc = "last run" })

vim.keymap.set("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "terminate debugging" })
