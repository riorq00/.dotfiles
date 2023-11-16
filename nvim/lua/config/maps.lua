local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- navigate within insert mode
keymap.set("i", "<C-h>", "<Left>", opts)
keymap.set("i", "<C-l>", "<Right>", opts)
keymap.set("i", "<C-j>", "<Down>", opts)
keymap.set("i", "<C-k>", "<Up>", opts)

-- line numbers
keymap.set("n", "<leader>n", "<cmd> set nu! <CR>")
keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>")

-- Format Prettier
keymap.set("n", "pr", ":Prettier<CR>")

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")
keymap.set("i", "JK", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabedit")

-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")

-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Open menu of translate
keymap.set({ "n", "v" }, "tran", require("config.translates.init"), opts)

-- Autotranslate to english
keymap.set("n", "tra", "<S-v>:Translate en<CR>", opts)

-- dap
local function sidebarOpen()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end
keymap.set("n", "<Leader>db", "<cmd> DapToggleBreakpoint <CR>", opts)
keymap.set("n", "<Leader>dus", sidebarOpen, opts)

keymap.set("n", "<F5>", function()
  require("dap").continue()
end)
keymap.set("n", "<F10>", function()
  require("dap").step_over()
end)
keymap.set("n", "<F11>", function()
  require("dap").step_into()
end)
keymap.set("n", "<F12>", function()
  require("dap").step_out()
end)
keymap.set("n", "<Leader>B", function()
  require("dap").set_breakpoint()
end)
keymap.set("n", "<Leader>lp", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
keymap.set("n", "<Leader>dr", function()
  require("dap").repl.open()
end)
keymap.set("n", "<Leader>dl", function()
  require("dap").run_last()
end)
keymap.set({ "n", "v" }, "<Leader>dh", function()
  require("dap.ui.widgets").hover()
end)
keymap.set({ "n", "v" }, "<Leader>dp", function()
  require("dap.ui.widgets").preview()
end)
keymap.set("n", "<Leader>df", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.frames)
end)
keymap.set("n", "<Leader>ds", function()
  local widgets = require("dap.ui.widgets")
  widgets.centered_float(widgets.scopes)
end)

-- Moving Higlighted line like vscode
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
