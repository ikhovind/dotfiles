return {
  {
    "barreiroleo/ltex_extra.nvim",
    ft = { "latex", "tex", "bib", "markdown" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local setup_done = false
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not (client and client.name == "ltex_plus") then return end
          if setup_done then return end
          setup_done = true

          -- Require ltex_extra first so package.loaded.ltex_extra is set,
          -- then patch catch_ltex before setup triggers init_check reload.
          -- catch_ltex uses nvim_get_current_buf() inside vim.schedule, which can
          -- race to a buffer without ltex attached; search all clients instead.
          local ltex_extra = require("ltex_extra")
          local commands_lsp = require("ltex_extra.commands-lsp")
          commands_lsp.catch_ltex = function()
            local getter = vim.lsp.get_clients or vim.lsp.get_active_clients
            local clients = getter({ name = "ltex_plus" })
            if vim.tbl_isempty(clients) then
              clients = getter({ name = "ltex" })
            end
            return clients[1]
          end

          ltex_extra.setup({
            load_langs = { "en-US" },
            init_check = true,
            path = ".ltex",
          })
        end,
      })
    end,
  },
}
