function nix-search --description 'Search for packages in nix package manager'
	nix-env -qaP --description | rg -i $argv
end
