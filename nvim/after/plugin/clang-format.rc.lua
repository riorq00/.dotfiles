local status, clangf = pcall(require, "vim-clang-format")
if not status then
  return
end

clangf.setup({})
