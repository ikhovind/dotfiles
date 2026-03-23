return {
  url = "https://codeberg.org/andyg/leap.nvim",
  dependencies = "tpope/vim-repeat",
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')

    require('leap').add_repeat_mappings(';', ',', {
      relative_directions = true,
      modes = {'n', 'x', 'o'},
    })
  end
}
