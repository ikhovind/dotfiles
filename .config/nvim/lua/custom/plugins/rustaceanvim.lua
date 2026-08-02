return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- recommended
  lazy = false, -- plugin loads on rust filetype automatically
  ft = { 'rust' },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          -- reuse your existing on_attach from custom/lsp.lua
          require('custom.lsp').on_attach(_, bufnr)

          -- add a hover-actions keymap, e.g. remap K specifically for rust buffers
          vim.keymap.set('n', 'K', function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
          end, { buffer = bufnr, desc = 'Hover with actions' })
        end,
      },
    }
  end,
}
