require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "html", "tsserver", "cssls" }
})

local on_attach = function()
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
require("lspconfig").tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require("lspconfig").html.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
