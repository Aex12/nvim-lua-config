local ts_pickers_ok, ts_pickers = pcall(require, 'telescope.pickers')
local ts_finders_ok, ts_finders = pcall(require, 'telescope.finders')
local ts_config_ok, ts_config = pcall(require, 'telescope.config')
local ts_make_entry_ok, ts_make_entry = pcall(require, 'telescope.make_entry')

local telescope_ok = ts_pickers_ok and ts_finders_ok and ts_config_ok and ts_make_entry_ok
if not telescope_ok then
  return vim.lsp.buf.definition
end

local ts_conf = ts_config.values
local getTelescopeTheme = require('appearance.get-telescope-theme')

local function make_lsp_buf_request_params (win, buf)
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  row = row - 1
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1]
  if not line then
    return { line = 0, character = 0 }
  end
  col = vim.str_utfindex(line, col)

  return {
    textDocument = { uri = vim.uri_from_bufnr(buf) },
    position = { line = row, character = col },
    context = { includeDeclaration = true },
  }
end

local function goto_definition ()
  local method = "textDocument/definition"
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  local params = make_lsp_buf_request_params(win, buf)

  vim.lsp.buf_request(buf, method, params, function(err, result, ctx, _)
    -- if err, notify
    if err then
      vim.api.nvim_err_writeln("an error happened getting definitions: " .. err.message)
      return
    end
    -- if no result, stop execution
    if result == nil or #result == 0 then
      vim.api.nvim_err_writeln("no definitions found")
      return
    end

    -- flatten results
    local flattened_results = {}
    if result then
      -- textDocument/definition can return Location or Location[]
      if not vim.tbl_islist(result) then
        flattened_results = { result }
      end

      vim.list_extend(flattened_results, result)
    end

    local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding

    -- if there is only one reuslt, jump directly to it
    if (#flattened_results == 1) then
      vim.lsp.util.jump_to_location(flattened_results[1], offset_encoding)
      return
    end

    -- if there are more than 1 results, show a list of them
    local locations = vim.lsp.util.locations_to_items(flattened_results, offset_encoding)

    vim.pretty_print(locations)

    local ts_opts = getTelescopeTheme()

    ts_pickers.new(ts_opts, {
      prompt_title = 'LSP definitions',
      finder = ts_finders.new_table({
        results = locations,
        entry_maker = ts_make_entry.gen_from_quickfix(ts_opts)
      }),
      previewer = ts_conf.qflist_previewer(ts_opts),
      sorter = ts_conf.generic_sorter(ts_opts),
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    })
    :find()

    -- trouble.close()
    -- trouble.open "lsp_definitions"
  end)
end

return goto_definition
