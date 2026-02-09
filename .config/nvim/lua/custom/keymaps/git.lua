local wk = require("which-key")

-- Create a command that opens Git log in a separate buffer (full window)
vim.api.nvim_create_user_command('Glog', function(opts)
  vim.cmd('Git log --stat ' .. opts.args)
  vim.cmd('only')
end, { nargs = '*' })

-- Add keymaps for git buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "git",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local wk = require("which-key")

    -- Rebase interactively from commit under cursor
    vim.keymap.set('n', '<leader>gr', function()
      -- Get the current line
      local line = vim.api.nvim_get_current_line()
      -- Extract commit hash (first word on the line)
      local hash = line:match("^commit%s+(%x+)") or line:match("^(%x+)")

      if hash then
        -- Rebase from parent of this commit (so this commit is included)
        vim.cmd('Git rebase -i ' .. hash .. '^')
      else
        print("No commit hash found on this line")
      end
    end, { buffer = buf, desc = "Git rebase interactive from commit" })
  end,
})

wk.add({
  { "<leader>g", group = "Git" },
  { "<leader>gl", ":Glog<CR>", desc = "Git log", mode = "n" },
  { "<leader>gb", ":Git blame<CR>", desc = "Git blame", mode = "n" },
})

return {}
