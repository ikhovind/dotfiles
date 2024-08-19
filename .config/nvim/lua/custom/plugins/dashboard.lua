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
        --          project = { enable = true, limit = 8, icon = 'your icon', label = '', action = new_tab },
        week_header = {
         enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
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

