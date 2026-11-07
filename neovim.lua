-- Carrera for Neovim: aether with a developer-tuned syntax map.
-- Rule: colour carries meaning, weight stays regular. Only the cursor line
-- number and matching brackets are bold; red is for keywords and errors only.
--
--   keywords      Guards Red      def class if return import
--   functions     Gentian Blue    calls and definitions
--   types/classes Racing Yellow   Model, QuerySet, str
--   strings       Python Green
--   numbers/const Lava Orange     42, True, None, CONSTANTS
--   decorators    Cognac          @property @action @dataclass
--   builtins      Ruby Star       self cls super print
--   attributes    soft Miami Blue obj.field, kwargs=
--   parameters    Chalk, italic
--   comments      unlit marking grey, italic
local p = {
  bg = "#111214", dark_bg = "#0c0d0e", darker_bg = "#08090a", lighter_bg = "#1b1d21",
  fg = "#d9d5cc", dark_fg = "#7b7f87", light_fg = "#b8b5ad", bright_fg = "#f3f0e9",
  muted = "#6b6f78", trim = "#2a2d33", rule = "#3a3d44",
  red = "#e5484d", guards = "#e8323c", bright_red = "#ff6e6a",
  orange = "#f2803a", yellow = "#f2c230", bright_yellow = "#ffd866",
  green = "#93c25e", bright_green = "#b0d983",
  cyan = "#2fb5d6", soft_cyan = "#7fc6d8", bright_cyan = "#6fd3ec",
  blue = "#6a97da", bright_blue = "#93b6ec",
  magenta = "#d672a2", bright_magenta = "#eb9cc2", brown = "#b07a4f",
}

local function tint(hex, amount) -- blend a colour into the background
  local function ch(h, i) return tonumber(h:sub(i, i + 1), 16) end
  local out = "#"
  for _, i in ipairs({ 2, 4, 6 }) do
    out = out .. string.format("%02x", math.floor(ch(p.bg, i) + (ch(hex, i) - ch(p.bg, i)) * amount + 0.5))
  end
  return out
end

return {
  {
    "omacom/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = true },
        keywords = {},
        functions = {},
        variables = {},
      },
      colors = {
        bg = p.bg, dark_bg = p.dark_bg, darker_bg = p.darker_bg, lighter_bg = p.lighter_bg,
        fg = p.fg, dark_fg = p.dark_fg, light_fg = p.light_fg, bright_fg = p.bright_fg, muted = p.muted,
        red = p.red, yellow = p.yellow, orange = p.orange, green = p.green, cyan = p.cyan,
        blue = p.blue, magenta = p.magenta, brown = p.brown,
        bright_red = p.bright_red, bright_yellow = p.bright_yellow, bright_green = p.bright_green,
        bright_cyan = p.bright_cyan, bright_blue = p.bright_blue, bright_magenta = p.bright_magenta,
        accent = p.guards, cursor = p.guards, foreground = p.fg, background = p.bg,
        selection = p.trim, selection_foreground = p.bright_fg, selection_background = p.trim,
      },
      on_highlights = function(hl)
        local set = function(group, spec) hl[group] = spec end

        -- syntax
        for _, g in ipairs({ "Keyword", "Statement", "Conditional", "Repeat", "Exception", "Include",
          "@keyword", "@keyword.function", "@keyword.return", "@keyword.import", "@keyword.conditional",
          "@keyword.repeat", "@keyword.exception", "@keyword.operator", "@keyword.coroutine" }) do
          set(g, { fg = p.red })
        end
        for _, g in ipairs({ "Function", "@function", "@function.call", "@function.method",
          "@function.method.call", "@constructor" }) do
          set(g, { fg = p.blue })
        end
        for _, g in ipairs({ "Type", "Typedef", "Structure", "@type", "@type.definition", "@type.builtin" }) do
          set(g, { fg = p.yellow })
        end
        set("String", { fg = p.green })
        set("@string.documentation", { fg = tint(p.green, 0.72), italic = true })
        set("@string.escape", { fg = p.bright_cyan })
        set("@string.regexp", { fg = p.bright_cyan })
        for _, g in ipairs({ "Number", "Float", "Boolean", "Constant", "@number", "@boolean",
          "@constant", "@constant.builtin" }) do
          set(g, { fg = p.orange })
        end
        set("@attribute", { fg = p.brown })
        set("@attribute.builtin", { fg = p.brown })
        set("PreProc", { fg = p.brown })
        for _, g in ipairs({ "@variable.builtin", "@function.builtin", "@module.builtin" }) do
          set(g, { fg = p.magenta })
        end
        set("@variable", { fg = p.fg })
        set("@variable.member", { fg = p.soft_cyan })
        set("@property", { fg = p.soft_cyan })
        set("@variable.parameter", { fg = p.light_fg, italic = true })
        set("@variable.parameter.builtin", { fg = p.light_fg, italic = true })
        set("@module", { fg = p.bright_blue })
        set("@label", { fg = p.bright_blue })
        set("Operator", { fg = p.dark_fg })
        set("@operator", { fg = p.dark_fg })
        set("Delimiter", { fg = p.dark_fg })
        set("@punctuation.delimiter", { fg = p.dark_fg })
        set("@punctuation.bracket", { fg = p.dark_fg })
        set("@punctuation.special", { fg = p.bright_cyan })
        set("Comment", { fg = p.muted, italic = true })
        set("@comment", { fg = p.muted, italic = true })
        set("Todo", { fg = p.darker_bg, bg = p.yellow, bold = true })
        set("@comment.todo", { fg = p.darker_bg, bg = p.yellow, bold = true })
        set("@comment.note", { fg = p.darker_bg, bg = p.blue, bold = true })
        set("@comment.warning", { fg = p.darker_bg, bg = p.orange, bold = true })
        set("@comment.error", { fg = p.bright_fg, bg = p.guards, bold = true })
        set("@tag", { fg = p.red })
        set("@tag.attribute", { fg = p.soft_cyan })
        set("@tag.delimiter", { fg = p.dark_fg })

        -- editor chrome: graphite dash, red needle
        set("CursorLine", { bg = p.lighter_bg })
        set("CursorLineNr", { fg = p.guards, bold = true })
        set("LineNr", { fg = p.rule })
        set("LineNrAbove", { fg = p.rule })
        set("LineNrBelow", { fg = p.rule })
        set("Visual", { bg = tint(p.guards, 0.22) })
        set("Search", { fg = p.bright_fg, bg = tint(p.yellow, 0.35) })
        set("IncSearch", { fg = p.darker_bg, bg = p.yellow })
        set("CurSearch", { fg = p.darker_bg, bg = p.yellow })
        set("MatchParen", { fg = p.bright_red, bold = true, underline = true })
        set("WinSeparator", { fg = p.trim })
        set("FloatBorder", { fg = p.rule, bg = p.dark_bg })
        set("FloatTitle", { fg = p.guards, bg = p.dark_bg, bold = true })
        set("NormalFloat", { fg = p.fg, bg = p.dark_bg })
        set("Pmenu", { fg = p.fg, bg = p.dark_bg })
        set("PmenuSel", { fg = p.bright_fg, bg = p.trim, bold = true })
        set("PmenuThumb", { bg = p.rule })
        set("Folded", { fg = p.dark_fg, bg = p.lighter_bg, italic = true })
        set("NonText", { fg = p.trim })
        set("Whitespace", { fg = p.trim })
        set("SnacksIndent", { fg = p.lighter_bg })
        set("SnacksIndentScope", { fg = p.rule })

        -- diagnostics: undercurl, tinted virtual text
        local diag = { Error = p.bright_red, Warn = p.yellow, Info = p.blue, Hint = p.cyan, Ok = p.green }
        for name, c in pairs(diag) do
          set("Diagnostic" .. name, { fg = c })
          set("DiagnosticVirtualText" .. name, { fg = c, bg = tint(c, 0.10), italic = true })
          set("DiagnosticUnderline" .. name, { undercurl = true, sp = c })
        end

        -- diffs and git signs
        set("DiffAdd", { bg = tint(p.green, 0.16) })
        set("DiffDelete", { bg = tint(p.red, 0.16) })
        set("DiffChange", { bg = tint(p.blue, 0.12) })
        set("DiffText", { bg = tint(p.blue, 0.30) })
        set("GitSignsAdd", { fg = p.green })
        set("GitSignsChange", { fg = p.blue })
        set("GitSignsDelete", { fg = p.red })
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
