local status, colorizer = pcall(require, "colorizer")
if not status then
  return
end

colorizer.setup({
  "*",
  opts = {
    user_default_options = {
      tailwind = true,
    },
  },
})
