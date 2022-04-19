local theme_styles = {
  night = "night",
  day = "day",
  storm = "storm"
}

vim.g.tokyonight_style = theme_styles.night

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]

return theme_styles

