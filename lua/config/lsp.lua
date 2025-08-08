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

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
    on_attach = lsp_on_attach,
    settings = {
    },
})


-- TODO add Javascript
