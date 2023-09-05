local opt = vim.opt
local g = vim.g

opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }

opt.list = true
opt.listchars:append({ eol = "↴", trail = "-" })

opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

require'alpha'.setup(require'alpha.themes.startify'.config)

require('telescope').load_extension('projects')
