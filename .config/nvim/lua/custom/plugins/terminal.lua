local wk = require("which-key")

wk.register({
  t = {
    name = "Terminal/Tabs", -- optional group name
    t = { "<cmd>:ToggleTerm size=40 dir=~/Desktop direction=horizontal<CR>", "[t]oggle [t]erminal" },
    -- additional options for creating the keymap
    -- n = { "New File" }, -- just a label. don't create any mapping
    -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
}, { prefix = "<leader>" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit termial mode" })

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function ()
  end,
}


