local function get_git_path (path)
  local dirname = vim.fs.dirname(path)

  local exists_git = vim.fn.filereadable(dirname .. '/.git/config')

  if (exists_git == 1) then
    return dirname
  end

  if (dirname == '/') then
    return nil
  end

  return get_git_path(dirname)
end

return get_git_path
