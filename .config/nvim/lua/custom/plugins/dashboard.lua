local function new_tab()
    -- vim.cmd.tabnew()
    vim.cmd("Telescope find_files cwd=")
    --local a = vim.fn['getcwd']()
    --vim.api.nvim_echo({{"tcd " .. a}}, true, {})
    --vim.cmd("tcd " .. a)
end

return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      change_to_vcs_root = true,
      config = {
        mru = { enable = false },
        project = { enable = false },
        week_header = {
         enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        },
      },
      hide = {
          statusline = false,    -- hide statusline default is true
          tabline    = false,       -- hide the tabline
          winbar     = false        -- hide winbar

      },
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

