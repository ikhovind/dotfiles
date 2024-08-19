return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = true,
      patterns = { ".nvim_proj" }
    },
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    keys = {
    },
  }
}
