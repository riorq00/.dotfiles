local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    timeout_ms = 2200,
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup({
  sources = {
    -- null_ls.builtins.formatting.prettierd,
    --[[ null_ls.builtins.formatting.prettier.with({
            disabled_filetypes = { "html", "c", "cpp", "csharp", "css" },
            runtime_condition = function(params)
              return true
            end,
            timeout = 5000,
        }), ]]
    --[[ null_ls.builtins.formatting.clang_format.with({
      filetypes = { "c", "cpp" },
      extra_args = { "-style=file" },
    }), ]]
    null_ls.builtins.formatting.prettierd.with({
      filetypes = { "html", "css", "tsx", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    }),
    -- null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.stylua.with({
      filetypes = { "lua", "luado" },
    }),
    null_ls.builtins.formatting.eslint_d.with({
      -- js/ts linter
      -- only enable eslint if root has .eslintrc.js
      diagnostics_format = "[eslint] #{m}\n(#{c})",
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js", ".eslintrc.json") -- change file extension if you use something else
      end,
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end,
})

vim.api.nvim_create_user_command("DisableLspFormatting", function()
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
end, { nargs = 0 })
