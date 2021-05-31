local gl = require("galaxyline")
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

table.insert(gls.left, {
  GitBranch = {
    provider = "GitBranch",
    condition = condition.check_git_workspace,
    icon = " ",
    separator = "  ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.orange, colors.bg },
  },
})

table.insert(gls.left, {
  FileName = {
    provider = "FileName",
    condition = condition.hide_in_width,
    icon = " ",
    separator = "  ",
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.left, {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { colors.green, colors.bg },
  },
})
table.insert(gls.left, {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { colors.blue, colors.bg },
  },
})
table.insert(gls.left, {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { colors.red, colors.bg },
  },
})

table.insert(gls.right, {
  DiagnosticError = { provider = "DiagnosticError", icon = " ", highlight = { colors.red, colors.bg } },
})
table.insert(gls.right, {
  DiagnosticWarn = { provider = "DiagnosticWarn", icon = " ", highlight = { colors.orange, colors.bg } },
})

table.insert(gls.right, {
  DiagnosticInfo = { provider = "DiagnosticInfo", icon = " ", highlight = { colors.yellow, colors.bg } },
})

table.insert(gls.right, {
  DiagnosticHint = { provider = "DiagnosticHint", icon = " ", highlight = { colors.blue, colors.bg } },
})

table.insert(gls.right, {
  TreesitterIcon = {
    provider = function()
      if next(vim.treesitter.highlighter.active) ~= nil then
        return " "
      end
      return ""
    end,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.green, colors.bg },
  },
})

table.insert(gls.right, {
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      local tbl = { ["dashboard"] = true, [" "] = true }
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = "  ",
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  LineInfo = {
    provider = "LineColumn",
    separator = "  ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  Tabstop = {
    provider = function()
      return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  BufferType = {
    provider = "FileTypeName",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.right, {
  Space = {
    provider = function()
      return " "
    end,
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.orange, colors.bg },
  },
})

table.insert(gls.short_line_left, {
  BufferType = {
    provider = "FileTypeName",
    separator = " ",
    separator_highlight = { "NONE", colors.bg },
    highlight = { colors.grey, colors.bg },
  },
})

table.insert(gls.short_line_left, {
  SFileName = {
    provider = "SFileName",
    condition = condition.buffer_not_empty,
    highlight = { colors.grey, colors.bg },
  },
})
