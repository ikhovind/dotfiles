# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on kickstart.nvim, extended with custom plugins and keymaps organized under `lua/custom/`. The configuration uses lazy.nvim as the plugin manager and includes comprehensive LSP support, testing frameworks, and C/C++ development tools.

## Architecture

### Plugin Management
- **Base**: kickstart.nvim template (see init.lua)
- **Plugin Manager**: lazy.nvim (auto-bootstrapped if not present)
- **Custom Extensions**: `lua/custom/plugins/` - all files here are auto-imported by lazy.nvim
- **Custom Keymaps**: `lua/custom/keymaps/` - keymap definitions loaded at startup
- **Custom Snippets**: `lua/custom/snippets/` - language-specific snippets

### Directory Structure
```
init.lua                    # Main entry point with core plugin setup
lua/custom/
  ├── plugins/              # Custom plugin configurations
  ├── keymaps/              # Custom keybindings
  └── snippets/             # Custom snippets
lua/config/                 # Configuration modules
```

### Key Plugin Ecosystem

**Core Infrastructure**:
- `lazy.nvim` - Plugin manager
- `which-key.nvim` - Keybinding hints
- `telescope.nvim` - Fuzzy finder
- `nvim-treesitter` - Syntax highlighting and code understanding

**LSP & Completion**:
- `nvim-lspconfig` - LSP configurations
- `mason.nvim` + `mason-lspconfig.nvim` - LSP server management
- `nvim-cmp` - Completion engine (configured with keyword_length=3, no auto-preselect)
- `LuaSnip` - Snippet engine
- `neodev.nvim` - Lua LSP enhancement for Neovim
- `goto-preview` - Preview definitions in floating windows

**File & Project Management**:
- `neo-tree.nvim` - File explorer (width: 40, left position, follows current file)
- `project.nvim` - Project detection and switching (via Telescope)
- `bufferline.nvim` - Buffer tabs visualization
- `persistence.nvim` - Session management

**Git Integration**:
- `vim-fugitive` + `vim-rhubarb` - Git commands
- `gitsigns.nvim` - Git decorations in sign column

**C/C++ Development**:
- `cmake-tools.nvim` - CMake integration with extensive configuration
  - Build directory: `out/${variant:buildType}`
  - Build options: `-j8`
  - Executor: quickfix (vertical split, width 90)
  - Runner: toggleterm (tab mode)
  - DAP integration with codelldb
- `neotest` + `neotest-ctest` - Test runner using CTest for automatic executable detection
  - Supports GoogleTest, Catch2, and doctest frameworks
  - Requires CMake test discovery (e.g., `gtest_discover_tests()`, `add_test()`)

**Motion & Editing**:
- `leap.nvim` - Fast cursor movement
- `Comment.nvim` - Code commenting
- `flatten.nvim` - Nested Neovim instance handling
- `scope.nvim` - Buffer scoping per tab

**UI & UX**:
- `dashboard` - Start screen
- `lualine.nvim` - Status line (onedark theme, no icons)
- `toggleterm.nvim` - Terminal management
- `indent-blankline.nvim` - Indentation guides
- `onedark.nvim` - Color scheme

**AI Assistance**:
- `copilot.lua` - GitHub Copilot integration
  - Suggestions: Auto-trigger, 75ms debounce
  - Accept: `<M-l>`, Next: `<M-j>`, Prev: `<M-k>`, Dismiss: `<M-h>`
  - Disabled for: yaml, markdown, help, gitcommit

**Additional Tools**:
- `navbuddy` - LSP symbol navigation
- `knap` - Preview for LaTeX/Markdown
- `markdown-preview.nvim` - Markdown preview

## LSP Configuration

Configured language servers (in `servers` table):
- `pylsp` - Python (with rope_autoimport and pydocstyle enabled)
- `lua_ls` - Lua (with checkThirdParty=false)

LSP keybindings are set via `on_attach` function in init.lua:442-469.

## Key Bindings

**Leader Key**: `<Space>`

### File & Search (`<leader>f`)
- `<leader>ff` - Find files
- `<leader>fb` - Find buffers
- `<leader>fn` - Navbuddy (symbol navigation)
- `<leader>fp` - Find projects

### Text Search (`<leader>s`)
- `<leader>sg` - Live grep

### Buffers (`<leader>b`)
- `<S-h>` / `<S-l>` - Cycle prev/next buffer
- `<leader>bo` - Close other buffers
- `<leader>bp` - Pick buffer to close
- `<leader>bt` - Open terminal buffer

### Window Navigation
- `<C-h/j/k/l>` - Navigate to left/down/up/right window
- `<C-Up/Down/Left/Right>` - Resize windows

### Tabs
- `<A-h>` / `<A-l>` - Previous/next tab
- `<leader>td` - Close tab
- `<leader>tn` - New tab with Dashboard

### CMake (`<leader>c`)
- `<leader>cg` - CMake Generate
- `<leader>cb` - CMake Build

### Testing (`<leader>t`)
- `<leader>tf` - Run tests in current file
- `<leader>tt` - Run nearest test
- `<leader>tw` - Run workspace tests
- `<leader>tr` - Show short results
- `<leader>tR` - Show full results

### LSP (`<leader>l` when attached)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Go to references
- `gI` - Go to implementation
- `K` - Hover documentation
- `<C-s>` - Signature help
- `<leader>rn` - Rename
- `<leader>la` - LSP action (code actions)
- `<leader>D` - Type definition
- `<leader>ds` - Document symbols
- `<leader>ws` - Workspace symbols

### Git (`<leader>g`)
- `<leader>gp` - Go to previous hunk
- `<leader>gn` - Go to next hunk
- `<leader>ph` - Preview hunk

### Diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `<leader>e` - Open floating diagnostic
- `<leader>q` - Open diagnostics list

## Common Development Workflows

### Working with CMake Projects
1. `<leader>cg` or `:CMakeGenerate` - Generate build files (uses presets if available)
2. `<leader>cb` or `:CMakeBuild` - Build project with `-j8`
3. `:CMakeRun` - Run the built executable in toggleterm
4. Build artifacts go to `out/${buildType}/`

### Running Tests
Use neotest keybindings (`<leader>t*`) with CTest integration. Tests can be run at file, function, or workspace level.

**CMake Configuration Required:**
In your CMakeLists.txt, use CMake's test discovery to enable automatic executable detection:
```cmake
enable_testing()
find_package(GTest REQUIRED)

add_executable(my_test test.cpp)
target_link_libraries(my_test GTest::GTest GTest::Main)

# Auto-discover tests - this is required for neotest-ctest
gtest_discover_tests(my_test)
```

After running `<leader>cg` (CMakeGenerate) and `<leader>cb` (CMakeBuild), neotest will automatically detect your test executables through CTest - no manual configuration needed!

### LSP Server Installation
LSP servers are automatically installed via Mason when listed in the `servers` table (init.lua:479-508). Run `:Mason` to manage installations manually.

### Plugin Management
- Plugins auto-update on startup (checker enabled)
- Add new plugins in `lua/custom/plugins/*.lua`
- Each file should return a table with lazy.nvim plugin spec
- Lock file: `lazy-lock.json`

## Editor Settings

Key options set in init.lua:
- Tab width: 4 spaces
- Shift width: 2 spaces
- Line numbers enabled
- Mouse enabled
- Clipboard synced with OS
- Update time: 250ms
- Timeout length: 300ms
- Case-insensitive search (unless uppercase in pattern)

## Treesitter Languages

Ensured installed: c, cpp, go, lua, python, rust, tsx, typescript, vimdoc, vim, luadoc, markdown

## Notes for Development

- Custom plugin files are auto-sourced from `lua/custom/plugins/` - no need to require them explicitly
- Keymaps can be organized in separate files under `lua/custom/keymaps/`
  - Files in this directory are auto-imported by lazy.nvim and must return `{}`
  - LSP keymaps are in `lua/custom/lsp.lua` (not in keymaps/) and exported via `on_attach` function
- Which-key groups are defined using `wk.add()` (see telescope.lua, buffer.lua, and lsp.lua examples)
- Completion won't auto-select first item (keyword_length=3, select=false in confirm)
- Neo-tree follows current file automatically and won't close when last window
