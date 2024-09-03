local wk = require("which-key")

wk.add(
  {
    { "<leader>r", group = "Rename" },
    { "<leader>rc", "<cmd>%s/\r//g<cr>", desc = "[r]emove [c]arriage return" },
  }
)

return {}
