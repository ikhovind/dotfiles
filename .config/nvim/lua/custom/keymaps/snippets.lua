local wk = require("which-key")

vim.keymap.set('n', '<leader>fs', '<cmd>Telescope luasnip<cr>', { desc = '[F]ind [S]nippets' })
wk.add(
  {
    { "<leader>fn", "<cmd>Telescope luasnip<cr>", desc = "[F]ind S[n]ippets", mode = "n"  }
  }
)

return {}
