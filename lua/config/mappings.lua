-- Set leader key to space
vim.g.mapleader = " "
 
local status, fzf = pcall(require, 'fzf-lua')
local find_files = status and fzf.files or '<nop>'
local resume = status and fzf.resume or '<nop>'
local buffers = status and fzf.buffers or '<nop>'
local grep = status and fzf.grep_live or '<nop>'

local symbols = status and fzf.lsp_document_symbols or vim.lsp.buf.document_symbol
local references = status and fzf.lsp_references or vim.lsp.buf.references
local definition = status and fzf.lsp_definition or vim.lsp.buf.definition
local declaration = status and fzf.lsp_declaration or vim.lsp.buf.declaration


-- Normal mode
nnoremaps({
    -- Stop moving a char with space
    ["<space>"] = "<nop>",

    -- Window navigation
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Create a terminal
    ["<leader>t"] = ":term<CR>:keepalt file<space>",

    -- Buffers
    ['<leader>b'] = buffers,

    -- Find files
    ['<leader>ff'] = find_files,

    -- Resume picker
    ['<leader>fr'] = resume,

    -- Find with grep
    ["<leader>fg"] = grep,

    ['<leader>ld'] = definition,
    ['<leader>lD'] = declaration,
    ['<leader>lr'] = references,
    ['<leader>ls'] = symbols,

})

-- Normal mode bindings when attached to lsp
lsp_normal = {
}

-- Insert mode bindings when attached to lsp
lsp_insert = {
    ['<C-n>'] = '<C-x><C-o>',
}

-- Terminal mode
tnoremaps({
    -- Escape from terminal
    ["<esc>"] = "<C-\\><C-n>",
})
