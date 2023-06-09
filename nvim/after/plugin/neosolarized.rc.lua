local status, n = pcall(require, "neosolarized")
if not status then
  return
end

n.setup({
  comment_italics = true,
  background_set = false,
})

local cb = require("colorbuddy.init")
local Color = cb.Color
local colors = cb.colors
local Group = cb.Group
local groups = cb.groups
local styles = cb.styles

Color.new("white", "#ffffff")
Color.new("black", "#000000")
Color.new("background", "#002b36")
Color.new("red", "#B42E31")
Color.new("blue", "#268bd2")

Group.new("Normal", colors.base1, colors.NONE, styles.NONE)
Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
Group.new("CursorLineNr", colors.yellow, colors.NONE, styles.NONE, colors.base1)
Group.new("Visual", colors.none, colors.base03, styles.reverse)
Group.new("SagaNormal", colors.none, colors.background, styles.NONE)
Group.new("CmpItemMenu", colors.none, colors.background, styles.NONE)

-- CHANGE SOME COLORS TO THE OLD VERSION OF THE THEME
-- n.Group.new("@parameter", n.colors.base0)
-- n.Group.new("@variable", n.colors.base0)
-- n.Group.new("Special", colors.red)
-- n.Group.new("Preproc", colors.orange)

-- CHANGE PUNCTUATION COLOR TO RED (LIKE OLD VERSION)
-- n.Group.new("@punctuation.delimiter", colors.red)
-- n.Group.new("@punctuation.bracket", colors.red)
-- n.Group.new("@punctuation.special", colors.red) ]]

local cError = groups.Error.fg
local cInfo = groups.Information.fg
local cWarn = groups.Warning.fg
local cHint = groups.Hint.fg

Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)

-- TEMPORARY
--vim.api.nvim_set_hl(0, "@lsp.type.variable", {})

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
