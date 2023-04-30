require("mason").setup()
require("neodev").setup()

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "html", "tsserver", "cssls" }
})

-- local on_attach = function()
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--   vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {})
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
--   vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
--   vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
--   vim.keymap.set('n', '<leader>f', function()
--     vim.lsp.buf.format { async = true }
--   end, opts)
-- end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { 'lua_ls', 'tsserver', 'html', "cssls", "tailwindcss", "pyright" }

local on_attach_tsserver = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() 
        vim.cmd(":Prettier")
        vim.lsp.buf.format()
      end

    })
  end
end

for _, val in pairs(servers) do
  if val == 'tsserver' then
    require('lspconfig')[val].setup {
      on_attach = on_attach_tsserver,
      capabilities = capabilities
    }
    elseif val == 'lua_ls'  then
    require('lspconfig')[val].setup {
      -- on_attach = on_attach,
       settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  },

      capabilities = capabilities
    }

  else
    require('lspconfig')[val].setup {
      -- on_attach = on_attach,
      capabilities = capabilities
    }
  end
end


-- require("lspconfig").lua_ls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
-- require("lspconfig").tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
--
-- require("lspconfig").html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
-- print(require("lspconfig"))
--
--


-- LSP SAGA KEYMAP CONFIG
local keymap = vim.keymap.set

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file

-- Rename all occurrences of the hovered word for the selected files
keymap("n", "<F2>", "<cmd>Lspsaga rename ++project<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Go to type definition
keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")


-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Show workspace diagnostics
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

-- Show cursor diagnostics
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- If there is no hover doc,
-- there will be a notification stating that
-- there is no information available.
-- To disable it just use ":Lspsaga hover_doc ++quiet"
-- Pressing the key twice will enter the hover window
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"

-- Call hierarchy
keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
-- keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
