local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

local map = vim.keymap

saga.setup({
  ui = {
    border = "rounded",
    -- theme = "round",
    --[[ colors = {
      normal_bg = "#002b36",
    }, ]]
  },
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
})

local opts = { noremap = true, silent = true }

map.set("n", "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
map.set("n", "C-o", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
map.set("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
map.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
map.set("n", "gf", "<Cmd>Lspsaga lsp_finder<CR>", opts)
map.set("i", "<C-v>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

map.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
map.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

map.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
map.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts)

map.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
map.set("n", "gr", "<cmd>Lspsaga rename ++project<CR>", opts)

map.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
map.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)

map.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

map.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>", opts)
