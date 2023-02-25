return function ()
  -- Neotree Specific. Unless you are still migrating, remove the deprecated commands from v1.x
  vim.g.neo_tree_remove_legacy_commands = 1

  local events = require("neo-tree.events")

  local function on_file_move (args)
    vim.pretty_print(args)
    local ts_clients = vim.lsp.get_active_clients({ name = "tsserver" })
    for _, ts_client in ipairs(ts_clients) do
      ts_client.request("workspace/executeCommand", {
        command = "_typescript.applyRenameFile",
        arguments = {
          {
            sourceUri = vim.uri_from_fname(args.source),
            targetUri = vim.uri_from_fname(args.destination),
          },
        },
      })
    end
  end

  local function system_open (state)
    local node = state.tree:get_node()
    local path = node:get_id()
    local platform = require('util.platform')

    if platform == 'Darwin' then
      vim.api.nvim_command(string.format("silent !open -g '%s'", path))
    elseif platform == 'Linux' then
      vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
    end
  end

  local function on_file_opened ()
    local prevbuf = vim.fn.bufnr("#")
    if prevbuf < 1 then
      print('prevbuf < 1')
      return
    end

    local prevtype = vim.api.nvim_buf_get_option(prevbuf, "filetype")
    if prevtype ~= "neo-tree" then
      local manager = require('neo-tree.sources.manager')
      print('prevtype ~= neotree')
      manager.close_all('left')
      return
    end
  end

  require('neo-tree').setup({
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        mappings = {
          ["o"] = "system_open",
          ["<C-c>"] = "clear_filter",
        },
      },
      commands = {
        system_open = system_open
      }
    },
    window = {
      mappings = {
        ["Wf"] = function() vim.api.nvim_exec("Neotree show filesystem current", false) end,
        ["Wb"] = function() vim.api.nvim_exec("Neotree show buffers current", false) end,
        ["Wg"] = function() vim.api.nvim_exec("Neotree show git_status current", false) end,
      },
    },
    event_handlers = {
      {
        event = events.FILE_MOVED,
        handler = on_file_move,
      },
      {
        event = events.FILE_RENAMED,
        handler = on_file_move,
      },
      {
        event = events.FILE_OPENED,
        handler = on_file_opened,
      },
    },
  })
end
