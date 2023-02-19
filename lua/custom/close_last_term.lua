local function find_chan_by_buf (buf)
  local channels = vim.api.nvim_list_chans()
  for _, chan in ipairs(channels) do
    if (chan.buffer == buf) then
      return chan
    end
  end
  return nil
end

local function chan_send_termcodes(chan, data)
  return vim.api.nvim_chan_send(
    chan,
    vim.api.nvim_replace_termcodes(data, true, false, true)
  )
end

local function close_last_term ()
  local buf = vim.g.last_term_buffer
  local chan = find_chan_by_buf(buf)

  vim.pretty_print(chan)

  if (chan == nil or chan.mode ~= 'terminal') then
    return
  end

  chan_send_termcodes(chan.id, '<C-c>eexit<CR>')
end

close_last_term()

return close_last_term
