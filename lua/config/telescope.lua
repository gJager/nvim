local telescope_actions = require("telescope.actions")

-- Telescope insert mode
telescope_insert = {
    -- I dont like their 'normal' mode. Close the telescope on escape.
    ["<esc>"] = telescope_actions.close,

    ["<C-l>"] = telescope_actions.cycle_history_next,
    ["<C-h>"] = telescope_actions.cycle_history_prev,
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

