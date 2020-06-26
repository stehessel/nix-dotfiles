lua <<EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = false,
		disable = { 'rust' },
	},
	-- this enables incremental selection
	incremental_selection = {
    	enable = true,
    	keymaps = {                       -- mappings for incremental selection (visual mappings)
    		init_selection = 'gk',       -- maps in normal mode to init the node/scope selection
    		node_incremental = "l",       -- increment to the upper named parent
    		node_decremental = "h",       -- decrement to the previous node
    		scope_incremental = "u",      -- increment to the upper scope (as defined in locals.scm)
    		scope_decremental = "d",      -- increment to the lower scope (as defined in locals.scm)
    	}
    },
	ensure_installed = 'all'
}
EOF
