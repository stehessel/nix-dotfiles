return {
  {
    "anuvyklack/hydra.nvim",
    config = function()
      local Hydra = require("hydra")
      local gitsigns = require("gitsigns")

      local hint = [[
 _J_: next hunk    _s_: stage hunk         _d_: show deleted    _b_: blame line
 _K_: prev hunk    _u_: undo stage hunk    _p_: preview hunk    _B_: blame show full
 ^ ^               _S_: stage buffer       ^ ^                  _/_: show base file
 ^
 _G_: Neogit       _<Enter>_: Gitui        _q_: exit
        ]]

      Hydra({
        name = "Git",
        hint = hint,
        config = {
          color = "pink",
          invoke_on_body = true,
          hint = {
            position = "bottom",
            border = "rounded",
          },
          on_enter = function()
            vim.cmd("mkview")
            vim.cmd("silent! %foldopen!")
            vim.bo.modifiable = false
            gitsigns.toggle_linehl(true)
            gitsigns.toggle_signs(true)
          end,
          on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            vim.cmd("loadview")
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd("normal zv")
            gitsigns.toggle_deleted(false)
            gitsigns.toggle_linehl(false)
          end,
        },
        mode = { "n", "x" },
        body = "<Leader>g",
        heads = {
          {
            "J",
            function()
              if vim.wo.diff then
                return "]c"
              end
              vim.schedule(function()
                gitsigns.next_hunk()
              end)
              return "<Ignore>"
            end,
            { expr = true, desc = "next hunk" },
          },
          {
            "K",
            function()
              if vim.wo.diff then
                return "[c"
              end
              vim.schedule(function()
                gitsigns.prev_hunk()
              end)
              return "<Ignore>"
            end,
            { expr = true, desc = "prev hunk" },
          },
          { "s", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "stage hunk" } },
          { "u", gitsigns.undo_stage_hunk, { desc = "undo last hunk" } },
          { "S", gitsigns.stage_buffer, { desc = "stage buffer" } },
          { "p", gitsigns.preview_hunk, { desc = "preview hunk" } },
          { "d", gitsigns.toggle_deleted, { nowait = true, desc = "toggle deleted" } },
          { "b", gitsigns.blame_line, { nowait = true, desc = "blame" } },
          {
            "B",
            function()
              gitsigns.blame_line({ full = true })
            end,
            { desc = "full blame" },
          },
          { "/", gitsigns.show, { exit = true, desc = "show base file" } },
          { "G", "<Cmd>Neogit<CR>", { exit = true, desc = "Neogit" } },
          {
            "<Enter>",
            function()
              local gitui = require("FTerm"):new({
                cmd = "gitui",
                dimensions = {
                  height = 0.9,
                  width = 0.9,
                },
              })
              gitui:toggle()
            end,
            { exit = true, desc = "Gitui" },
          },
          { "q", nil, { exit = true, nowait = true, desc = "exit" } },
        },
      })
    end,
    dependencies = "anuvyklack/keymap-layer.nvim",
    keys = { "<Leader>g" },
  },
}
