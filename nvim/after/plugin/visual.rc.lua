local status, visual_multi = pcall(require, "vim-visual-multi")
if not status then
  return
end

visual_multi.setup({})
