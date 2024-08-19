local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
  -- important! fmt does not return a snippet, it returns a table of nodes.
  s("itdic", fmt([[
  for key, item in {}.items():
    print(key, item)
  ]], {
    -- i(1) is at nodes[1], i(2) at nodes[2].
    i(1, "dictionary")
  })),
})
return {}
