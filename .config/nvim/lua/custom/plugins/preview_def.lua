--nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
--nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
--nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
--nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
--nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
local wk = require("which-key")

wk.register({
  ["g"] = {
    name = "+Goto",
    P = {"<cmd>lua require('goto-preview').close_all_win()<CR>",  "Close all previews"},

  },
  ["gp"] = {
    name = "+Preview",
    d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview definition" },
    t = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Preview type" },
    i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Preview implementation" },
    r = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "Preview references" },
  },
})

vim.keymap.set("n", "<esc>", "<cmd>lua require('goto-preview').close_all_win()<CR>")

return {
  'rmagatti/goto-preview',
  -- it doesn't work if you don't set opts
   opts = {}, -- it works

  -- this also works
  --      config = function()
  --        require("goto-preview").setup()
  --      end,

  -- this doesn't work
  -- main = "goto-preview",
}

