print('loading mlsp')

local status, telescope_builtin = pcall(require, 'telescope.builtin')

local references = status and telescope_builtin.lsp_references or vim.lsp.buf.references
local definition = status and telescope_builtin.lsp_definition or vim.lsp.buf.definition
local declaration = status and telescope_builtin.lsp_declaration or vim.lsp.buf.declaration

-- lsp normal
lsp_normal = {
    ['gd'] = definition,
    ['gD'] = declaration,
    ['gr'] = references,
}

lsp_insert = {
    ['<C-n>'] = '<C-x><C-o>',
}

-- ========== Setup nvim-lspconfig ===========
local lsp_on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Prevent perview window from being opened
    vim.opt.completeopt = { "menu" }

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    for k, v in pairs(lsp_normal) do
        vim.keymap.set('n', k, v, bufopts)
    end
    for k, v in pairs(lsp_insert) do
        vim.keymap.set('i', k, v, bufopts)
    end
end

  
vim.lsp.enable('basedpyright')
vim.lsp.config('basedpyright', {
    on_attach = lsp_on_attach,
    settings = {
        basedpyright = {
            typeCheckingMode = "standard",
--            reportImplicitOverride = false,
        },
    },
})

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
    on_attach = lsp_on_attach,
    settings = {
    },
})

-- -- Set keybindings when a language server is used
-- local on_attach = function(client, bufnr)
--   -- Enable completion triggered by <c-x><c-o>
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--  
--   -- Mappings.
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
--   vim.keymap.set('n', '<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts)
--   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
-- end
-- 
-- -- Install lsps
-- require('lspconfig')['pyright'].setup{
--     on_attach = on_attach,
-- }
-- 
-- -------- Null - lsp --------
-- local null_ls = require("null-ls")
-- 
-- -- register any number of sources simultaneously
-- local sources = {
--     null_ls.builtins.diagnostics.ruff.with({extra_args = {
-- 	    "--select", "F",		-- Pyflakes: errors
-- 	    "--select", "E",		-- pycodestyle
-- 	    "--select", "W",		-- pycodestyle
-- 	    "--select", "D",		-- docstrings
-- 	    "--select", "N", 		-- pep8-naming
-- 	    "--select", "C90", 		-- mccabe: complexity
-- 	    "--select", "A", 		-- flakee8-builtins
--     }}),
-- }
-- 
-- null_ls.setup({ sources = sources })
