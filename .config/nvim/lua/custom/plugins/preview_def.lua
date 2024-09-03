--nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
--nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
--nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
--nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
--nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
local wk = require("which-key")

wk.add({
  {
    { "g", group = "Goto" },
    { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close all previews" },
    { "gp", group = "Preview" },
    { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview definition" },
    { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview implementation" },
    { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview references" },
    { "gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview type" },
  }
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

