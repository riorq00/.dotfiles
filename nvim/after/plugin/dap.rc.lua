local dap = require("dap")
local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--[[ dap.adapters.lldb = {
  type = "executable",
  -- absolute path is important here, otherwise the argument in the `runInTerminal` request will default to $CWD/lldb-vscode
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
} ]]

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

--[[ dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = "/usr/bin/codelldb",
    args = { "--port", "${port}" },
    -- On windows you may have to uncomment this:
    -- detached = false,
  },
} ]]
dap.configurations.rust = {
  type = "rust",
  request = "launch",
  name = "Launch file",
  program = "${file}",
  rustPath = function()
    return "/usr/bin/rustc"
  end,
}

dap.configurations.c = dap.configurations.cpp
--dap.configurations.rust = dap.configurations.cpp
