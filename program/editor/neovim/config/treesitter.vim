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
    		init_selection = 'gnn',       -- maps in normal mode to init the node/scope selection
    		node_incremental = "grn",     -- increment to the upper named parent
    		scope_incremental = "grc",    -- increment to the upper scope (as defined in locals.scm)
    		node_decremental = "grm",     -- decrement to the previous node
    	}
    },
	ensure_installed = 'all'
}
EOF
