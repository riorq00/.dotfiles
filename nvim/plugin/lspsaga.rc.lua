local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

local map = vim.keymap

saga.setup({
  ui = {
    border = "rounded",
    -- theme = "round",
    colors = {
      normal_bg = "#002b36",
    },
  },
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "gl", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)

vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>", opts)

-- code action
local codeaction = require("lspsaga.codeaction")
vim.keymap.set("n", "<leader>ca", function()
  codeaction:code_action()
end, { silent = true })
vim.keymap.set("v", "<leader>ca", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  codeaction:range_code_action()
end, { silent = true })
