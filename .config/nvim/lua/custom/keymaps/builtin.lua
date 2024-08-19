local wk = require("which-key")

wk.register({
  r = {
    name = "Rename", -- optional group name
    c = { "<cmd>%s/\r//g<cr>", "[r]emove [c]arriage return" },
  },
}, { prefix = "<leader>" })

return {}
