local wk = require("which-key")

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>bo", "<cmd>:BufferLineCloseOthers<cr>", desc = "[b]uffer close [o]thers" },
  { "<leader>bt", "<cmd>:tab term<cr>", desc = "[b]uffer [t]erminal" },
})

-- tabs
vim.keymap.set("n", "<A-h>", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "<A-l>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "close tab" })
-- vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr> <BAR> Dashboard<cr>", { desc = "close tab" })

vim.keymap.set('n', "<leader>tn",
  function()
    vim.cmd.tabnew()
    vim.cmd("Dashboard")
  end, { desc = "tab new" }
)


return {}
