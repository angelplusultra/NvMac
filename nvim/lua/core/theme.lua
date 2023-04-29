local M = {}

M.nightfox = 'nightfox'
M.oxocarbon = 'oxocarbon'
M.gruvbox = 'gruvbox'

M.set = function(theme)

vim.cmd("colorscheme " .. theme)
end

return M

