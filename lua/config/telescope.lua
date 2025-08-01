print('loading telescope')


local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

nnoremaps({
   -- Find files
   ['<leader>ff'] = telescope_builtin.find_files,

   -- Find buffers
   ['<leader>b'] = telescope_builtin.buffers,

   -- Find with grep
   ["<leader>fg"] = ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
})
 
-- Telescope insert mode
telescope_insert = {
    -- I dont like their 'normal' mode. Close the telescope on escape.
    ["<esc>"] = telescope_actions.close,

    ["<C-l>"] = telescope_actions.cycle_history_next,
    ["<C-h>"] = telescope_actions.cycle_history_prev,
    -- ["<C-m>"] = lga_actions.quote_prompt(),
}

-- ========== Setup telescope ==========
require('telescope').setup({
    defaults = {
        mappings = {
            i = telescope_insert,
        },
        -- Make telescope fill active window, not float over middle
        layout_strategy = 'current_buffer',
    },
})

