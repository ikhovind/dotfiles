local wk = require("which-key")

-- Register CMake which-key group
wk.add({
  { "<leader>c", group = "CMake" },
  { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "[C]Make [G]enerate" },
  { "<leader>cb", "<cmd>CMakeBuild<cr>", desc = "[C]Make [B]uild" },
})

return {}
