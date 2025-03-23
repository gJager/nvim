print("Loading config")


-- Setup paths so we can load our config
config_dir = debug.getinfo(1).source:match("@?(.*/)") .. "/../"
config_dir = vim.fn.resolve(config_dir)
plugin_dir = config_dir .. '/plugins'
vim.opt.runtimepath:append(config_dir)
vim.opt.runtimepath:append(plugin_dir)
vim.opt.packpath:append(plugin_dir)

-- Load other config files
require "config.intro"
require "config.map"
require "config.util"
require "config.mappings"
require "config.telescope"
require "config.lsp"
--require "treesitter"
 
local api = vim.api
 
-- ====================================================================
-- Basic setup
-- ====================================================================
 
-- Colorscheme
vim.cmd "set termguicolors"
vim.cmd [[colorscheme jellybeans]]
 
-- Prevent quitting when closing windows
vim.cmd [[cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>]]
vim.cmd [[cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'write' : 'wq')<CR>]]

-- Prevent window from closing when calling bd
function delete_buffer() 
    bufid = api.nvim_win_get_buf(0)
    status, ret = pcall(vim.cmd, "b intro")
    if not status then
        status, ret = pcall(vim.cmd, "bn")
    end

    status, ret = pcall(api.nvim_buf_delete, bufid, {})
    if not status then
        pcall(vim.cmd, "b " .. bufid)
    end
end
api.nvim_create_user_command("DeleteBuffer", delete_buffer, {})
vim.cmd [[cabbrev bd <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'DeleteBuffer' : '')<CR>]]

-- Tabs
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
 
-- Setup persistent undo
undo_dir = '/tmp/nvim/undo'
if not isdir(undo_dir) then
    print('Creating undo dir at '..undo_dir)
    os.execute('mkdir '..undo_dir) 
end
vim.opt.undodir = undo_dir
vim.opt.undofile = true

-- Make the cwd the current directory
-- vim.opt.autochdir = true
 
-- Put diagnostic messages in hoverwindow
vim.diagnostic.config({virtual_text = false})
vim.o.updatetime = 300
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Setup tab complete
vim.cmd "set wildmode=longest:full,list,full"
 
-- Turn off that terrible mouse support. Nooo thank you.
vim.cmd "set mouse="
 
