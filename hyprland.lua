-- Carrera: tail-light gradient on the focused window, plus a faint red glow
-- like brake lights on wet tarmac. Unfocused windows recede into the dash.
local active_border_color = { colors = { "rgba(e8323cee)", "rgba(8f0f18ee)" }, angle = 90 }
local inactive_border_color = "rgba(2a2d33cc)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    shadow = {
      enabled = true,
      range = 10,
      render_power = 3,
      color = "rgba(e8323c30)",
      color_inactive = "rgba(00000000)",
    },
  },
})
