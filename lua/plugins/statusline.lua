return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  event = 'VimEnter',
  lazy = true,
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine_ok, lualine = pcall(require, 'lualine')

    if not lualine_ok then
      return
    end
    
    -- Color table for highlights
    -- stylua: ignore
    local colors = {
      bg       = '#1F1F28',
      fg       = '#DCD7BA',
      gray     = '#54546D',
      yellow   = '#E6C384',
      cyan     = '#7FB4CA',
      green    = '#98BB6C',
      orange   = '#FFA066',
      violet   = '#957FB8',
      magenta  = '#D27E99',
      blue     = '#7E9CD8',
      red      = '#FF5D62',
      --
      filename = '#957FB8',
      -- git colors
      git_head = '#938AA9',
      git_add  = '#76946A',
      git_del  = '#C34043',
      git_chg  = '#DCA561',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        local columns = vim.opt.columns:get()
        return columns > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x ot right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- ins_left {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.border },
    --   padding = { left = 0, right = 1 },
    -- }

    ins_left({
      -- mode component
      function()
        local mode = vim.fn.mode()
        return ' ' .. mode
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 1, right = 1 },
    })

    ins_left({
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.filename, gui = 'bold' },
    })

    ins_left({ 'location', color = { fg = colors.gray } })

    ins_left({ 'progress', color = { fg = colors.gray } })

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left({
      function()
        return '%='
      end,
    })

    ins_left({
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' ',
      color = { fg = colors.fg },
    })

    ins_left({
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
      },
    })

    -- Add components to right sections
    ins_right({
      -- filesize component
      'filesize',
      color = { fg = colors.gray },
      cond = conditions.buffer_not_empty,
    })

    ins_right({
      'o:encoding', -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.gray, gui = 'bold' },
    })

    ins_right({
      'fileformat',
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.gray, gui = 'bold' },
    })

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    ins_right({
      'diff',
      -- Is it me or the symbol for modified us really weird
      source = diff_source,
      symbols = { added = ' ', modified = '柳', removed = ' ' },
      diff_color = {
        added = { fg = colors.git_add },
        modified = { fg = colors.git_chg },
        removed = { fg = colors.git_del },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      'b:gitsigns_head',
      icon = '',
      color = { fg = colors.git_head, gui = 'bold' },
      padding = { left = 1, right = 1 },
    })

    -- ins_right {
    --   function()
    --     return '▊'
    --   end,
    --   color = { fg = colors.border }, -- Sets highlighting of component
    --   padding = { left = 1 },
    -- }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
