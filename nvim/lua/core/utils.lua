local M = {}

function map(mode, keybind, cmd, opts)
  local options = { noremap = false }
  if opts
  then
    options = opts
  end

  vim.api.nvim_set_keymap(mode, keybind, cmd, options)

end

M.map = map


return M
