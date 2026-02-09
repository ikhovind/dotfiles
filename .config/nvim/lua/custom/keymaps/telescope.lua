local wk = require("which-key")

-- Open a file as "temporary" - auto-closes when you leave it
local function find_temporary()
  require('telescope.builtin').find_files({
    attach_mappings = function(_, map)
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      local function open_temporary(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          vim.cmd('edit ' .. vim.fn.fnameescape(entry.path))
          local bufnr = vim.api.nvim_get_current_buf()
          vim.api.nvim_create_autocmd('BufHidden', {
            buffer = bufnr,
            once = true,
            callback = function()
              -- Delay slightly to allow navigation to complete
              vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
                  vim.api.nvim_buf_delete(bufnr, { force = false })
                end
              end, 100)
            end,
          })
        end
      end

      map('i', '<CR>', open_temporary)
      map('n', '<CR>', open_temporary)
      return true
    end,
  })
end

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
    { "<leader>fs", "<cmd>Navbuddy<cr>", desc = "[F]ind [S]ymbols", mode = "n" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "[F]ind [P]roject", mode = "n" },
    { "<leader>ft", find_temporary, desc = "[F]ind [T]emporary (auto-close)", mode = "n" },
    { "<leader>s", group = "Text search" }, -- group
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search string", mode = "n" },
  }
)

return {}
