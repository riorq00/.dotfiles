local status, lazygit = pcall(require, "lazygit.nvim")
if not status then
  return
end

lazygit.setup()
