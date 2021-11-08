local MENU_OFFSET = 11
local function header(str)
  local height = vim.fn.winheight('%')
  local res = vim.split(str, '\n')
  if height - MENU_OFFSET < #res then
    res = vim.list_slice(res, 1, height - MENU_OFFSET)
  else
    table.remove(res)
  end

  return res
end

return header
