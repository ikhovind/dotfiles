return {
    'willothy/flatten.nvim',
    config = true,
    -- or pass configuration with
     opts = {
        hooks = {
            post_open = function(opts)
                if opts.filetype == "gitcommit" or opts.filetype == "gitrebase" then
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        buffer = opts.bufnr,
                        once = true,
                        callback = vim.schedule_wrap(function()
                            vim.cmd('bprevious')
                            vim.api.nvim_buf_delete(opts.bufnr, { force = true })
                        end)
                    })
                end
            end,
        },
        window = {
            open = "alternate",
            focus = "first"
        },
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false, priority = 1001,
}

