
-- Playback Controls
vim.keymap.set('n', '<leader>mp', ':silent !spotify_player playback play-pause<CR>', { desc = "Spotify: Play/Pause" })
vim.keymap.set('n', '<leader>mn', ':silent !spotify_player playback next<CR>', { desc = "Spotify: Next" })
vim.keymap.set('n', '<leader>mb', ':silent !spotify_player playback previous<CR>', { desc = "Spotify: Previous" })

-- Volume Controls
vim.keymap.set('n', '<leader>m+', ':silent !spotify_player playback volume --offset 5<CR>', { desc = "Spotify: Vol +" })
vim.keymap.set('n', '<leader>m-', ':silent !spotify_player playback volume --offset -5<CR>', { desc = "Spotify: Vol -" })
--
-- -- Quick Status Check (shows song info in Neovim command line)
-- vim.keymap.set('n', '<leader>ms', ':!spotify_player get playback<CR>', { desc = "Spotify: Status" })

return {}
