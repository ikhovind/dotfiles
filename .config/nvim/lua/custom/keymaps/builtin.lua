local wk = require("which-key")

wk.add(
  {
    { "<leader>r", group = "Rename" },
    { "<leader>rc", "<cmd>%s/\r//g<cr>", desc = "[r]emove [c]arriage return" },
    { "<leader>rw", "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", desc = "Remove Trailing whitespace", mode = "n" },
  }
)

return {}
