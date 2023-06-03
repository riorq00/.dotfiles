--vim.lsp.set_log_level("debug")

local util = require("lspconfig.util")
local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local protocol = require("vim.lsp.protocol")

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end
  end,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

nvim_lsp.flow.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
  capabilities = capabilities,
})

nvim_lsp.clangd.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  filetypes = { "c", "cpp" },
  cmd = { "clangd" },
  capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  root_dir = function()
    return vim.loop.cwd()
  end, -- run lsp for javascript in any directory
  capabilities = capabilities,
})

nvim_lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.lua_ls.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
  capabilities = capabilities,
})
nvim_lsp.tailwindcss.setup({
  on_attach = on_attach,
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
    },
  },
  capabilities = capabilities,
})

nvim_lsp.html.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  init_options = {
    provideFormatter = false,
  },
  capabilities = capabilities,
})

nvim_lsp.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { "html", "tailwindcss", "typescriptreact", "javascriptreact", "sass", "scss", "less" },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "■" },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = "■",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
