return function (ret, ...)
  for _, obj in ipairs({ ... }) do
    if (obj) then
      for k, v in pairs(obj) do
        ret[k] = v
      end
    end
  end
  return ret
end
