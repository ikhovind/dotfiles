local wk = require("which-key")

-- wk.register({
--   f = {
--     name = "File search", -- optional group name
--     f = { "<cmd>Telescope find_files<cr>", "[f]ile [f]ind" },
--     g = { "<cmd>Telescope git_files<cr>", "[f]ind [g]it file" },
--     h = { "<cmd>Telescope help_tags<cr>", "[f]ind [h]elp tags" },
--     r = { "<cmd>Telescope oldfiles<cr>", "[f]file [o]ld", noremap=false },
--     b = { "<cmd>Telescope buffers<cr>", "[f]ind [b]uffer" },
--     p = { "<cmd>Telescope projects<cr>", "[F]ind [P]rojects" },
--     -- additional options for creating the keymap
--     -- n = { "New File" }, -- just a label. don't create any mapping
--     -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
--     -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
--   },
--   s = {
--     name = "Text search",
--     w = { "<cmd>Telescope grep_string<cr>", "[s]earch with current [w]ord" },
--     g = { "<cmd>Telescope live_grep<cr>", "[s]earch with [g]rep" },
--     d = { "<cmd>Telescope diagnostics<cr>", "[s]earch [g]diagnostics" },
--     b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "[s]search fuzzily in current [b]uffer" },
--   }
--
-- }, { prefix = "<leader>" })

wk.add({
    { "<leader>f", group = "Find" }, -- group
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffer", mode = "n" },
    { "<leader>fn", "<cmd>Navbuddy<cr>", desc = "Find buffer", mode = "n" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find buffer", mode = "n" },
    { "<leader>s", group = "Text search" }, -- group
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search string", mode = "n" },
  }
)

return {}
