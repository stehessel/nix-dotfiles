return {
  { "isobit/vim-caddyfile", ft = "caddyfile" },
  { "towolf/vim-helm", event = "BufReadPre" },
  {
    "LhKipp/nvim-nu",
    config = true,
    event = "BufReadPre",
    opts = {},
  },
}
