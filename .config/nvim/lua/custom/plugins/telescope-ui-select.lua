return {
  'nvim-telescope/telescope-ui-select.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- You can customize the theme here
            -- Other options: get_ivy, get_cursor
          }
        }
      }
    }
    -- Load the extension
    require("telescope").load_extension("ui-select")
  end,
}
