return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
    local custom_horizon = require('lualine.themes.horizon')

    custom_horizon.normal.c.bg = '#2a2a2a'
    custom_horizon.insert.c.bg = '#2a2a2a'
    custom_horizon.visual.c.bg = '#2a2a2a'
    custom_horizon.replace.c.bg = '#2a2a2a'
    custom_horizon.command.c.bg = '#2a2a2a'
    custom_horizon.inactive.c.bg = '#2a2a2a'

    require('lualine').setup {
      options = {
        theme = custom_horizon,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      }
    }
  end
}
