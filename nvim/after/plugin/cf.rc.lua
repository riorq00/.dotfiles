local status, clang_format = pcall(require, "clang-format")
if not status then
  return
end

clang_format.setup({})
