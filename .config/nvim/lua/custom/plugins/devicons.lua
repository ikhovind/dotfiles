return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').set_icon({
      proto = {
        icon = "󰏗",
        color = "#6d8086",
        name = "Proto",
      }
    })
  end,
}
