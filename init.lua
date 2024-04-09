vim.o.number = true
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.cmd("colorscheme habamax")
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.showmode = false


-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- orgmode
local org = require('orgmode')

org.setup_ts_grammar()
org.setup({
    org_agenda_files = {'~/Documents/orgmode/*'}
})

-- headlines
local headlines = require('headlines')

headlines.setup({
    org = {
        fat_headlines = false,
    }
})

-- lualine
local lualine = require('lualine')

local custom_horizon = require'lualine.themes.horizon'

custom_horizon.normal.c.bg = '#2a2a2a'
custom_horizon.insert.c.bg = '#2a2a2a'
custom_horizon.visual.c.bg = '#2a2a2a'
custom_horizon.replace.c.bg = '#2a2a2a'
custom_horizon.command.c.bg = '#2a2a2a'
custom_horizon.inactive.c.bg = '#2a2a2a'

lualine.setup {
  options = {
    icons_enabled = true,
    theme = custom_horizon,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
