vim.opt.completeopt = "menu,menuone,noselect"

require("compe").setup({
  allow_prefix_unmatch = false,
  debug = false,
  enabled = true,
  min_length = 1,
  preselect = "always",
  throttle_time = 25,

  source = {
    buffer = true,
    calc = true,
    conjure = true,
    nvim_lsp = true,
    nvim_lua = true,
    orgmode = true,
    path = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

vimp.inoremap({ "expr", "silent" }, "<Tab>", function()
  if vim.fn.pumvisible() ~= 0 then
    return t("<C-n>")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end)

vimp.inoremap({ "expr", "silent" }, "<S-Tab>", function()
  if vim.fn.pumvisible() ~= 0 then
    return t("<C-p>")
  else
    return t("<C-h>")
  end
end)
