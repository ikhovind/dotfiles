local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
  s("listing", fmt([[
\begin{{listing}}[htbp]
  \begin{{minted}}{{{}}}
{}
  \end{{minted}}
  \caption[{}]{{{}}}
  \label{{lst:{}}}
\end{{listing}}]], {
    i(1, "C"),
    i(2),
    i(3, "short caption"),
    i(4, "long caption"),
    i(5, "label"),
  })),
},
  { key = "latex_snippets" }
)
return {}
