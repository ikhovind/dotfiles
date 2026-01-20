local wk = require("which-key")

-- Register CMake which-key group
wk.add({
  { "<leader>c", group = "CMake" },
  { "<leader>cg", "<cmd>CMakeGenerate<cr>", desc = "[C]Make [G]enerate" },
  { "<leader>cba", "<cmd>CMakeBuild --target all<cr>", desc = "[C]Make [B]uild [A]ll" },
  { "<leader>cpt", "<cmd>CMakeSelectBuildTarget<cr>", desc = "[C]Make [P]ick [T]arget" },
  { "<leader>cbt", "<cmd>CMakeBuild<cr>", desc = "[C]Make [B]uild [T]arget" },
  { "<leader>cpl", "<cmd>CMakeSelectLaunchTarget<cr>", desc = "[C]Make [P]ick [L]aunch" },
  { "<leader>cr", "<cmd>CMakeRun<cr>", desc = "[C]Make [R]un" },
})

return {}
