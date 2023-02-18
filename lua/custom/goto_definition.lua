local lsp = vim.lsp
local trouble_ok, trouble = pcall(require, "trouble")

if not trouble_ok then
  return lsp.buf.definition
end

local function lsp_buf_request (buf, method, params, handler)
  lsp.buf_request(buf, method, params, function(err, m, result)
    handler(err, method == m and result or m)
  end)
end

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
  }
end

local function notify_error(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = "goto_definition" })
end

local function goto_definition ()
  local method = "textDocument/definition"
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  local params = make_lsp_buf_request_params(win, buf)

  params.context = { includeDeclaration = true }

  lsp_buf_request(buf, method, params, function(err, result)
    if err then
      notify_error("an error happened getting definitions: " .. err.message)
      return
    end
    if result == nil or #result == 0 then
      return
    end
    if (#result == 1) then
      lsp.buf.definition()
    else
      trouble.close()
      trouble.open "lsp_definitions"
    end
  end)
end

  return goto_definition
