local M = {}

local state = {
  build_type = "Debug",
  target = nil,
}

local function get_build_dir()
  return vim.fn.getcwd() .. "/out/" .. state.build_type
end

local function run_in_vsplit(cmd)
  local prev_win = vim.api.nvim_get_current_win()
  vim.cmd("botright vsplit")
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)
  vim.fn.jobstart(cmd, {
    buf = buf,
    term = true,
    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 and vim.api.nvim_buf_is_valid(buf) then
          vim.api.nvim_buf_delete(buf, { force = true })
        end
      end)
    end,
  })
  vim.api.nvim_set_current_win(prev_win)
end

local function is_own_target(target, build_dir)
  local result = vim.fn.systemlist(string.format(
    "fd --type d -E '_deps' --glob '*.dir' out/Debug --no-ignore-vcs",
    build_dir, target
  ))
  return #result > 0
end

local function get_own_targets(build_dir)
  local result = vim.fn.systemlist(string.format(
    "fd --type d -E '_deps' --glob '*.dir' out/Debug --no-ignore-vcs",
    build_dir
  ))
  local set = {}
  for _, path in ipairs(result) do
    local name = path:match("([^/]+)%.dir/$")
    if name then set[name] = true end
  end
  return set
end

local function parse_targets(output, build_dir)
  local own_targets = get_own_targets(build_dir)
  local targets = {}
  for _, line in ipairs(output) do
    -- cmake --target help lines look like "... target_name"
    local target = line:match("^%.%.%.%s+(.+)$")
    if target then
      target = vim.trim(target)
      if not target:match("CMakeFiles/")
        and not target:match("%.o$")
        and not target:match("%.i$")
        and not target:match("%.s$")
        and not target:match("%.dir$")
        and not target:match("^Continuous")
        and not target:match("^Nightly")
        and not target:match("^Experimental")
        and not vim.tbl_contains({
          "all", "clean", "depend", "edit_cache", "install",
          "install/local", "install/strip", "list_install_components",
          "rebuild_cache", "clangformat"
        }, target)
        and target ~= ""
        and own_targets[target] ~= nil
      then
        table.insert(targets, target)
      end
    end
  end
  return targets
end

function M.pick_build_type()
  vim.ui.select({ "Debug", "Release", "RelWithDebInfo" }, {
    prompt = "Build type:",
  }, function(choice)
    if choice then
      state.build_type = choice
      vim.notify("CMake build type: " .. choice)
    end
  end)
end

function M.generate()
  local build_dir = get_build_dir()
  local cwd = vim.fn.getcwd()
  local cmd = string.format(
    "cmake -B %s -DCMAKE_BUILD_TYPE=%s -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_PARALLEL_LEVEL=6 -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache %s",
    build_dir, state.build_type, cwd
  )
  run_in_vsplit(cmd)
end

function M.pick_target()
  local build_dir = get_build_dir()
  if vim.fn.isdirectory(build_dir) == 0 then
    vim.notify("Build directory does not exist: " .. build_dir .. " — run generate first", vim.log.levels.ERROR)
    return
  end

  local cmd = { "cmake", "--build", build_dir, "--target", "help" }
  local output = {}
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      vim.list_extend(output, data)
    end,
    on_exit = function()
      vim.schedule(function()
        local targets = parse_targets(output, build_dir)
        if #targets == 0 then
          vim.notify("No targets found", vim.log.levels.WARN)
          return
        end
        vim.ui.select(targets, {
          prompt = "CMake target:",
        }, function(choice)
          if choice then
            state.target = choice
            vim.notify("CMake target: " .. choice)
          end
        end)
      end)
    end,
  })
end

function M.build_target()
  if not state.target then
    vim.notify("No target selected — run pick_target first", vim.log.levels.ERROR)
    return
  end
  local build_dir = get_build_dir()
  local cmd = string.format("cmake --build %s --target %s", build_dir, state.target)
  run_in_vsplit(cmd)
end

function M.build_all()
  local build_dir = get_build_dir()
  local cmd = string.format("cmake --build %s", build_dir)
  run_in_vsplit(cmd)
end

function M.status()
  vim.notify(string.format(
    "CMake — build type: %s | target: %s",
    state.build_type,
    state.target or "(none)"
  ))
end

-- Default keymaps under <leader>c namespace, can be overridden
function M.setup(opts)
  opts = opts or {}

  local keys = vim.tbl_deep_extend("force", {
    pick_build_type = "<leader>cpb",
    generate        = "<leader>cg",
    pick_target     = "<leader>cpt",
    build_target    = "<leader>cbt",
    build_all       = "<leader>cba",
    status          = "<leader>cs",
  }, opts.keys or {})

  vim.keymap.set("n", keys.pick_build_type, M.pick_build_type, { desc = "CMake: pick build type" })
  vim.keymap.set("n", keys.generate,        M.generate,        { desc = "CMake: generate" })
  vim.keymap.set("n", keys.pick_target,     M.pick_target,     { desc = "CMake: pick target" })
  vim.keymap.set("n", keys.build_target,    M.build_target,    { desc = "CMake: build target" })
  vim.keymap.set("n", keys.build_all,       M.build_all,       { desc = "CMake: build all" })
  vim.keymap.set("n", keys.status,          M.status,          { desc = "CMake: status" })
end

return M
