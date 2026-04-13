
return {
    'tamton-aquib/duck.nvim',
    config = function()
        local wk = require("which-key")
        wk.add({
            {
                { "<leader>d", group = "Duck" },
                { "<leader>dd", function() require("duck").hatch() end, desc = "Hatch a duck" },
                { "<leader>dk", function() require("duck").cook() end, desc = "Cook a duck" },
                { "<leader>da", function() require("duck").cook_all() end, desc = "Cook all ducks" },
            }
        })
    end
}
