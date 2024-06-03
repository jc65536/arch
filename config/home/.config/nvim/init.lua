vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.textwidth = 80

-- /: don't insert comment leader for inline comments
-- q: gq formatting
-- n: numbered lists
vim.opt.formatoptions = "j/qn"

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.laststatus = 1
vim.o.number = true
vim.o.signcolumn = "no"

-- Remove sign column and line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- vim.opt_local.signcolumn = "auto"
    end
})

-- Consistent search direction
vim.keymap.set("n", "n", function()
    local i = vim.v.searchforward + 1
    return ("Nn"):sub(i, i)
end, { expr = true })

vim.keymap.set("n", "N", function()
    local i = vim.v.searchforward + 1
    return ("nN"):sub(i, i)
end, { expr = true })

vim.keymap.set("n", ";", function()
    local i = vim.fn.getcharsearch().forward + 1
    return (",;"):sub(i, i)
end, { expr = true })

vim.keymap.set("n", ",", function()
    local i = vim.fn.getcharsearch().forward + 1
    return (";,"):sub(i, i)
end, { expr = true })

-- LSP shortcuts

-- Hover information
vim.keymap.set("n", "K", vim.lsp.buf.hover)

-- View implementation
vim.keymap.set("n", "<F12>", vim.lsp.buf.implementation)

-- View references
-- <F24> = <S-F12>
vim.keymap.set("n", "<F24>", vim.lsp.buf.references)

-- Rename
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)

--------------------------------------------------------------------------------
--
-- LSP and autocomplete setup
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    "clangd",
    "tsserver",
    "pyright",
    "bashls",
    "ocamllsp",
    "hls",
    "rust_analyzer",
    "gopls",
    "jdtls",
    "html",
    "cssls",
    "jsonls",
    "marksman",
    "texlab",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    })
end

-- luasnip setup
local luasnip = require("luasnip")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
